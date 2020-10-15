//
//  ForecatTableViewCell.swift
//  PerekrestokWeather
//
//  Created by Mark Kryzhanouski on 10/15/20.
//

import UIKit

class ForecatTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    func configureWith(forecast: Forecast) {
        dayLabel.text = forecast.day
        lowLabel.text = "\(forecast.low > 0 ? "+" : "")\(forecast.low)"
        highLabel.text = "\(forecast.high > 0 ? "+" : "")\(forecast.high)"
        if let conditionCode = ConditionCode(rawValue: Int(forecast.code)) {
            conditionImageView.image = UIImage(named: conditionCode.imageName())
        }
    }
}
