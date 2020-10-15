//
//  ForecastViewController.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/15/20.
//

import UIKit

class ForecastViewController: UIViewController {

    var forecasts: [Forecast]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecatTableViewCell,
              let forecast = forecasts?[indexPath.row] else {
            fatalError()
        }
        cell.configureWith(forecast: forecast)
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate {
}
