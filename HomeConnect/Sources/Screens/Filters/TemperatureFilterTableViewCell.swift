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

    private let temperatureSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()

    public func configure() {
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(temperatureSlider)

        temperatureLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        temperatureSlider.anchor(top: temperatureLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 50,
                               paddingRight: 50)
    }
}
