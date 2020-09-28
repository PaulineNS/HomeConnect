//
//  HomeCollectionViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties

    static let identifier = "HomeCollectionViewCell"

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

    private var deviceItem: DeviceItem? = nil {
        didSet {
            guard let device = self.deviceItem else { return }
            deviceNameLabel.text = device.deviceName
            switch device.productType {
            case .heater:
                deviceImageView.image = UIImage(named: "heater")
                self.backgroundColor = .red
            case .light:
                deviceImageView.image = UIImage(named: "light")
                self.backgroundColor = .blue
            case .rollerShutter:
                deviceImageView.image = UIImage(named: "rollerShutter")
                self.backgroundColor = .green
            default:
                return
            }
        }
    }

    func autoLayoutCell() {
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

    func updateCell(with device: DeviceItem) {
        self.deviceItem = device
    }

}
