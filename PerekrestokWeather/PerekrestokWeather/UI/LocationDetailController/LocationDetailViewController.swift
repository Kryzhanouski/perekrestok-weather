//
//  LocationDetailViewController.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/14/20.
//

import UIKit

enum ForecastPeriod: Int {
    case threeDays = 3
    case sevenDays = 7
}

class LocationDetailViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    
    private var forecastController: ForecastViewController?
    private(set) var location: Location!
    var forecastPeriod: ForecastPeriod = .threeDays {
        didSet {
            updateForecastView()
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d, HH:mm"
        return formatter
    }()
    
    static func instance(with location: Location) -> LocationDetailViewController {
        guard let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LocationDetailViewController") as? LocationDetailViewController else {
            fatalError()
        }
        detailController.location = location
        return detailController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = location.city
        dayLabel.text = LocationDetailViewController.dateFormatter.string(from: Date())
        let currentObservation = location.currentObservation
        sunriseLabel.text = currentObservation?.astronomy?.sunrise ?? "-"
        sunsetLabel.text = currentObservation?.astronomy?.sunset ?? "-"
        temperatureLabel.text = currentObservation?.condition.map({ "\($0.temperature>0 ?"+":"-")\($0.temperature)" }) ?? "-"
        conditionLabel.text = currentObservation?.condition?.text ?? "-"
        windLabel.text = "Wind \(currentObservation?.wind.map({"\($0.chill)"}) ?? "") m/s"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController as ForecastViewController:
            forecastController = viewController
            updateForecastView()
        default:
            break
        }
    }
    
    @IBAction func forecastRangeDidChange(_ sender: UISegmentedControl) {
        forecastPeriod = sender.selectedSegmentIndex == 0 ? .threeDays : .sevenDays
    }
    
    func updateForecastView() {
        guard let forecastsSet = location.forecasts,
           let forecasts = forecastsSet.array as? [Forecast],
           forecasts.count >= forecastPeriod.rawValue else {
            forecastController?.forecasts = []
            return
        }
        forecastController?.forecasts = Array(forecasts[0 ..< forecastPeriod.rawValue])
    }
}
