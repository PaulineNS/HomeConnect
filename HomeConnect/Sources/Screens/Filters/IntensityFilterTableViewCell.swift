//
//  IntensityFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class IntensityFilterTableViewCell: UITableViewCell {

    static let identifier = "IntensityFilterTableViewCell"

    private let intensityLabel: UILabel = {
        let label = UILabel()
        label.text = "Intensité :"
        return label
    }()

    private let intensitySlider: UISlider = {
        let slider = UISlider()
        return slider
    }()

    public func configure() {
        contentView.addSubview(intensityLabel)
        contentView.addSubview(intensitySlider)
        intensityLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        intensitySlider.anchor(top: intensityLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 50,
                               paddingRight: 50)

    }

}
