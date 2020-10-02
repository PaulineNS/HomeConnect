//
//  HomeCollectionViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Public Properties

    static let identifier = "HomeCollectionViewCell"

    // MARK: - Private Properties

    private var viewModel: HomeCellViewModel!

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(deviceImageView)
        stackView.addArrangedSubview(deviceNameLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    private lazy var deviceImageView: UIImageView = {
        let deviceImageView = UIImageView()
        deviceImageView.contentMode = .scaleAspectFit
        return deviceImageView
    }()

    private lazy var deviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()

    // MARK: - Public Methods

    func configure(with viewModel: HomeCellViewModel) {
        autoLayoutCell()
        self.viewModel = viewModel
        bindViewModel()
        self.viewModel.didUpdateCell()
    }

    // MARK: - Private Methods

    private func bindViewModel() {
        viewModel.deviceName = { [weak self] text in
            self?.deviceNameLabel.text = text
        }
        viewModel.imageName = { [weak self] name in
            self?.deviceImageView.image = UIImage(named: name)
        }
        viewModel.backgroundColorName = { [weak self] colorName in
            switch colorName {
            case "light":
                self?.backgroundColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
            case "heater":
                self?.backgroundColor = #colorLiteral(red: 0.684643507, green: 0.785309732, blue: 0.172726661, alpha: 1)
            case "roller":
                self?.backgroundColor = #colorLiteral(red: 0.2540504634, green: 0.4793154001, blue: 0.1733816266, alpha: 1)
            default:
                return
            }
        }
    }

    private func autoLayoutCell() {
        self.layer.cornerRadius = 10
        self.addSubview(cellStackView)
        cellStackView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 10,
                             paddingBottom: 10,
                             paddingRight: 10)
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        deviceImageView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 1/2).isActive = true
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
