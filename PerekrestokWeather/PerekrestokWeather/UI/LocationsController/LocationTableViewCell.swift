//
//  LocationTableViewCell.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/12/20.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    func configureWith(location: Location) {
        timeLabel.text = LocationTableViewCell.formatter.string(from: Date())
        cityLabel.text = location.city
        let temperature = location.currentObservation?.condition?.temperature
        temperatureLabel.text = temperature.map {"\($0)°"} ?? "-"
        if let code = location.currentObservation?.condition?.code,
           let conditionCode = ConditionCode(rawValue: Int(code)) {
            conditionImageView.image = UIImage(named: conditionCode.imageName())
        }
    }
}
