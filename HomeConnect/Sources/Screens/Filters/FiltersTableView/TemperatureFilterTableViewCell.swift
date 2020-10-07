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

    // MARK: - Private Properties

    private weak var delegate: TemperatureFilterTableViewCellDelegate?
    private var temperature = 0.0

    private let heaterPlusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        return button
    }()

    private let heaterMinusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusIcon"), for: .normal)
        return button
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "temperature_filter".localized
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

    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        temperatureValueLabel.text = "0.0"
    }

    // MARK: - Public Methods

    func configure(delegate: TemperatureFilterTableViewCellDelegate?) {
        self.delegate = delegate
    }

    // MARK: - Private Methods

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(temperatureStackView)
        temperatureLabel.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                paddingTop: 10, paddingLeft: 10, height: 30)
        temperatureValueLabel.anchor(width: 50, height: 30)
        temperatureStackView.anchor(top: temperatureLabel.bottomAnchor,
                                    paddingTop: 10)
        temperatureStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        configureEvents()
    }

    private func configureEvents() {
        heaterMinusButton.addTarget(
            self,
            action: #selector(didTapMinusButton),
            for: .touchUpInside
        )
        heaterPlusButton.addTarget(
            self,
            action: #selector(didTapPlusButton),
            for: .touchUpInside
        )
    }

    // MARK: - Selectors

    @objc private func didTapPlusButton() {
        guard temperature < 28.0 else { return }
        if temperature < 7.0 {
            temperature = 6.5
        }
        temperature += 0.5
        temperatureValueLabel.text = "\(temperature)"
        delegate?.didChangeTemperatureValue(with: "\(temperature)")
    }

    @objc private func didTapMinusButton() {
        guard temperature > 7.0 else {
            return
        }
        temperature -= 0.5
        temperatureValueLabel.text = "\(temperature)"
        delegate?.didChangeTemperatureValue(with: "\(temperature)")
    }
}

protocol TemperatureFilterTableViewCellDelegate: class {
    func didChangeTemperatureValue(with value: String)
}
