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
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    let positionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 0.9092797041, green: 0.7230312228, blue: 0.3200179338, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.2540504634, green: 0.4793154001, blue: 0.1733816266, alpha: 1)
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
