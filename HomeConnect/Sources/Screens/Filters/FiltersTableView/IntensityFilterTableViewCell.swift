//
//  IntensityFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class IntensityFilterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let identifier = "IntensityFilterTableViewCell"
    weak var delegate: IntensityFilterTableViewCellDelegate?

    let intensitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = #colorLiteral(red: 0.9092797041, green: 0.7230312228, blue: 0.3200179338, alpha: 1)
        slider.thumbTintColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
        slider.isContinuous = true
        return slider
    }()

    // MARK: - Private Properties

    private let intensityLabel: UILabel = {
        let label = UILabel()
        label.text = "intensity_filter".localized
        return label
    }()

    let intensitySliderValue: UILabel = {
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

    // MARK: - Public Methods

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
        delegate?.didChangeIntensityValue(with: String(value))
    }

}

protocol IntensityFilterTableViewCellDelegate: class {
    func didChangeIntensityValue(with value: String)
}
