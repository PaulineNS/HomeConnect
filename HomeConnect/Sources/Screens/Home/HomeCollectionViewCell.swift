//
//  HomeCollectionViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    var stackView: UIStackView = UIStackView()
    var deviceImageView: UIImageView = UIImageView()
    var deviceNameLabel: UILabel = UILabel()

    func autoLayoutCell() {
        self.backgroundColor = .red
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
        deviceImageView.image = UIImage(named: "heater")
        deviceImageView.contentMode = .scaleAspectFit

        //autolayout deviceNameLabel
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.text = "devices"
        deviceNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        deviceNameLabel.numberOfLines = 0

        stackView.addArrangedSubview(deviceNameLabel)
        // stackView setting
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
    }

}
