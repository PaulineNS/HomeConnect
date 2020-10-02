//
//  TemperatureFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class TemperatureFilterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let identifier = "TemperatureFilterTableViewCell"

    let heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        return button
    }()

    let heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusIcon"), for: .normal)
        return button
    }()

    // MARK: - Private Properties

    private var temperature = 0.0

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Température (Radiateurs):"
        return label
    }()

    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(heaterMinusButton)
        stackView.addArrangedSubview(temperatureValueLabel)
        stackView.addArrangedSubview(heaterPlusButton)
        return stackView
    }()

    private lazy var temperatureValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(temperature)"
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
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(temperatureStackView)
        temperatureLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        temperatureValueLabel.anchor(width: 50, height: 30)
        temperatureStackView.anchor(top: temperatureLabel.bottomAnchor,
                               paddingTop: 10
                           )
        temperatureStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    // MARK: - Selectors

    @objc func didTapPlusButton() {
        guard temperature < 28.0 else { return }
        if temperature < 7.0 {
            temperature = 6.5
        }
        temperature += 0.5
        temperatureValueLabel.text = "\(temperature)"
    }

    @objc func didTapMinusButton() {
        guard temperature < 28.0 else { return }
        if temperature < 7.0 {
            temperature = 6.5
        }
        temperature += 0.5
        temperatureValueLabel.text = "\(temperature)"
    }
}
