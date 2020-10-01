//
//  PostionFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class PositionFilterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let identifier = "PositionFilterTableViewCell"

    // MARK: - Private Properties

    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position (Volets):"
        return label
    }()

    private let positionSliderValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3.0
        return label
    }()

    let positionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .red
        slider.thumbTintColor = .black
        slider.isContinuous = true
        return slider
    }()

    // MARK: - Public Methods

    public func configure() {
        contentView.addSubview(positionLabel)
        contentView.addSubview(positionSliderValue)
        contentView.addSubview(positionSlider)

        positionLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        positionSliderValue.anchor(top: contentView.topAnchor,
                                   left: positionLabel.rightAnchor,
                                   paddingTop: 10,
                                   paddingLeft: 10,
                                   width: 50,
                                   height: 30)
        positionSliderValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        positionSlider.anchor(top: positionLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 50,
                               paddingRight: 50)
    }

    // MARK: - Selectors

    @objc func didMovePositionSlider() {
        let value = Int(positionSlider.value)
        positionSliderValue.text = String(value)
    }

}
