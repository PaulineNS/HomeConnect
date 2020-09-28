//
//  IntensityFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class IntensityFilterTableViewCell: UITableViewCell {

    static let identifier = "IntensityFilterTableViewCell"

    private let intensityLabel: UILabel = {
        let label = UILabel()
        label.text = "Intensité :"
        return label
    }()

    public func configure() {
        contentView.addSubview(intensityLabel)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        intensityLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width, height: 100)
    }

}
