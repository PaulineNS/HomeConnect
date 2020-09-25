//
//  HomeCollectionViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties

    private var stackView: UIStackView = UIStackView()
    private var deviceImageView: UIImageView = UIImageView()
    private var deviceNameLabel: UILabel = UILabel()
    private var device: DeviceElement? = nil {
        didSet {
            guard let device = self.device else { return }
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
            }
        }
    }

    func autoLayoutCell() {
        self.layer.cornerRadius = 10
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        //autolayout deviceImageView
        stackView.addArrangedSubview(deviceImageView)
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        deviceImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 2/3).isActive = true
        deviceImageView.contentMode = .scaleAspectFit

        //autolayout deviceNameLabel
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        deviceNameLabel.numberOfLines = 0

        // stackView setting
        stackView.addArrangedSubview(deviceNameLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
    }

    func updateCell(with device: DeviceElement) {
        self.device = device
    }

}
