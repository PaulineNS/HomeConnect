//
//  PostionFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class PositionFilterTableViewCell: UITableViewCell {

    static let identifier = "PositionFilterTableViewCell"

    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position :"
        return label
    }()

    public func configure() {
        contentView.addSubview(positionLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        positionLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width, height: 100)
    }

}
