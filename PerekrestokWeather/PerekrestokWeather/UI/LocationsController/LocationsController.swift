//
//  LocationsController.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/12/20.
//

import UIKit
import CoreData

class LocationsController: UIViewController {
    
    enum TableSection {
        case locations([Location])
        case addNewLocation

        var numberOfRows: Int {
            switch self {
            case .locations(let locations): return locations.count
            case .addNewLocation: return 1
            }
        }

        var rowHeight: CGFloat {
            return 70
        }

        var cellIdentifier: String {
            switch self {
            case .locations: return "LocationTableViewCell"
            case .addNewLocation: return "AddNewLocationTableViewCell"
            }
        }
    }

    @IBOutlet private var tableView: UITableView!
    
    private lazy var weatherService = DependencyModule.resolve(WeatherService.self)
    private var locations: [Location] = []
    private var tableSections: [TableSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        fetchLocations()
    }
    
    @IBAction func addNewLocation(_ sender: Any) {
        let addLocationController = AddLocationViewController.newInstance()
        addLocationController.delegate = self
        let navController = UINavigationController(rootViewController: addLocationController)
        present(navController, animated: true)
    }

    private func configureTableView() {
        let refreshControll = UIRefreshControl()
        refreshControll.tintColor = .white
        refreshControll.addAction(UIAction(handler: { [weak self] _ in
            self?.fetchLocations()
        }), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControll
    }
    private func fetchLocations() {
        
        weatherService.fetchWeatherByLocations { (result, _) in
            switch result {
            case .success(let weatherResult):
                self.locations = weatherResult.locations
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    private func reloadTableSections() {
        var sections: [TableSection] = []
        if !locations.isEmpty {
            sections.append(.locations(locations))
        }
        tableSections = sections
    }
}

extension LocationsController: UITableViewDataSource {
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
        case .locations(let locations):
            if let locationCell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath) as? LocationTableViewCell {
                locationCell.configureWith(location: locations[indexPath.row])
                return locationCell
            }
        case .addNewLocation:
            return tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
           case .locations(let locations) = tableSections[indexPath.section] {
            try? weatherService.removeLocation(locations[indexPath.row])
            fetchLocations()
        }
    }
}

extension LocationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = tableSections[indexPath.section]
        if case .locations(let locations) = section {
            let detailViewController = LocationDetailViewController.instance(with: locations[indexPath.row])
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension LocationsController: AddLocationViewControllerDelegate {
    func addLocationViewController(_ controller: AddLocationViewController, didSelectLocation: String) {
        dismiss(animated: true, completion: nil)
        fetchLocations()
    }
}

