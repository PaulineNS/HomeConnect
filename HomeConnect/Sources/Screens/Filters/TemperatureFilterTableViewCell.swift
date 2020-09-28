//
//  TemperatureFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class TemperatureFilterTableViewCell: UITableViewCell {

    static let identifier = "TemperatureFilterTableViewCell"

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Température :"
        return label
    }()

    public func configure() {
        contentView.addSubview(temperatureLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        temperatureLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width, height: 100)
    }
}
