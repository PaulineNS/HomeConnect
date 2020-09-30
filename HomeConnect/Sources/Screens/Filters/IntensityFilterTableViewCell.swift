//
//  IntensityFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class IntensityFilterTableViewCell: UITableViewCell {

    static let identifier = "IntensityFilterTableViewCell"

    private let intensityLabel: UILabel = {
        let label = UILabel()
        label.text = "Intensité (Lumière):"
        return label
    }()

    private let intensitySliderValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3.0
        label.text = "0"
        return label
    }()

    let intensitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .red
        slider.thumbTintColor = .black
        slider.isContinuous = true
        return slider
    }()

    public func configure() {
        contentView.addSubview(intensityLabel)
        contentView.addSubview(intensitySliderValue)
        contentView.addSubview(intensitySlider)
        intensityLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        intensitySliderValue.anchor(top: contentView.topAnchor,
                                    left: intensityLabel.rightAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 10,
                                    width: 50,
                                    height: 30)
        intensitySliderValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        intensitySlider.anchor(top: intensityLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 50,
                               paddingRight: 50)

    }

    // MARK: - Selectors

    @objc func didMoveIntensitySlider() {
        let value = Int(intensitySlider.value)
        intensitySliderValue.text = String(value)
    }

}
