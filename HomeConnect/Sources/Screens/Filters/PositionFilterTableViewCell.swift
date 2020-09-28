//
//  PostionFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class PositionFilterTableViewCell: UITableViewCell {

    static let identifier = "PositionFilterTableViewCell"

    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position :"
        return label
    }()

    private let positionSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()

    public func configure() {
        contentView.addSubview(positionLabel)

        contentView.addSubview(positionSlider)

        positionLabel.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              paddingTop: 10, paddingLeft: 10, height: 30)
        positionSlider.anchor(top: positionLabel.bottomAnchor,
                               left: contentView.leftAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 50,
                               paddingRight: 50)
    }
}
