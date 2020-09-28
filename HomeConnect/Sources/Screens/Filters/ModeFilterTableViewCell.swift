//
//  ModeFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

class ModeFilterTableViewCell: UITableViewCell {

    static let identifier = "ModeFilterTableViewCell"

    private let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode :"
        return label
    }()

    public func configure() {
        contentView.addSubview(modeLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        modeLabel.frame = CGRect(x: 105, y: 5, width: contentView.frame.size.width, height: 100)
    }
}
