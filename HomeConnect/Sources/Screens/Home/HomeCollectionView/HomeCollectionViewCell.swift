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
        stackView.distribution = .equalSpacing
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
                self?.backgroundColor = #colorLiteral(red: 0.8992391229, green: 0.8554247022, blue: 0.2918801904, alpha: 1)
            case "heater":
                self?.backgroundColor = #colorLiteral(red: 0.8271351457, green: 0.3662813902, blue: 0.310879916, alpha: 1)
            case "roller":
                self?.backgroundColor = #colorLiteral(red: 0.391444236, green: 0.4994882345, blue: 0.5847318769, alpha: 1)
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
        deviceImageView.heightAnchor.constraint(equalTo: cellStackView.heightAnchor, multiplier: 2/3).isActive = true
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
