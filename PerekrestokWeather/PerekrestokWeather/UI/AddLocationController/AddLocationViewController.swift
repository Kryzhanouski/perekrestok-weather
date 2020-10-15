//
//  AddLocationViewController.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/14/20.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate: class {
    func addLocationViewController(_ controller: AddLocationViewController, didSelectLocation: String)
}

class AddLocationViewController: UIViewController {
    
    enum TableSection {
        case placemarks([CLPlacemark])
        case emptyResult

        var numberOfRows: Int {
            switch self {
            case .placemarks(let placemarks): return placemarks.count
            case .emptyResult: return 1
            }
        }

        var rowHeight: CGFloat {
            return 70
        }

        var cellIdentifier: String {
            switch self {
            case .placemarks: return "PlacemarkTableViewCell"
            case .emptyResult: return "NoResults"
            }
        }
    }

    weak var delegate: AddLocationViewControllerDelegate?
    
    static func newInstance() -> AddLocationViewController {
        guard let addLocationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddLocationViewController") as? AddLocationViewController else {
            fatalError()
        }
        return addLocationController
    }

    @IBOutlet private var tableView: UITableView!

    private var foundPlacemarks: [CLPlacemark]?
    private var tableSections: [TableSection] = []
    private lazy var weatherService = DependencyModule.resolve(WeatherService.self)

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.prompt = "Enter city, postcode or airport location"
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateSearch()
    }

    
    private func reloadTableSections() {
        guard let searchText = searchController.searchBar.text,
              searchText.count >= 3 else {
            tableSections = []
            return
        }

        var sections: [TableSection] = []
        if let foundPlacemarks = foundPlacemarks, !foundPlacemarks.isEmpty {
            sections.append(.placemarks(foundPlacemarks))
        }
        else {
            sections.append(.emptyResult)
        }
        tableSections = sections
    }

    private func activateSearch() {
        navigationItem.searchController?.isActive = true
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .compact)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .compactPrompt)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .defaultPrompt)
    }
}

extension AddLocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        reloadTableSections()
        return tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableSections[indexPath.section].rowHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tableSections[indexPath.section]
        switch section {
        case .placemarks(let placemarks):
            let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
            cell.textLabel?.text = "\(placemarks[indexPath.row].name ?? ""), \(placemarks[indexPath.row].country ?? "")"
            return cell
        case .emptyResult:
            let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
            cell.textLabel?.text = "No result found."
            return cell
        }
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = tableSections[indexPath.section]
        if case .placemarks(let placemarks) = section,
           let placeName = placemarks[indexPath.row].name {
            try? weatherService.addNewLocation(name: placeName)
            delegate?.addLocationViewController(self, didSelectLocation: placeName)
        }
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.dismiss(animated: true)
    }
}

extension AddLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              searchText.count >= 3 else {
            self.foundPlacemarks = []
            self.tableView.reloadData()
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { (placemarks, error) in
            self.foundPlacemarks = placemarks
            self.tableView.reloadData()
        }
    }
}

