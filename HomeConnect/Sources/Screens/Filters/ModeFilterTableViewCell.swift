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

    private let modeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        return mySwitch
    }()

    public func configure() {
        contentView.addSubview(modeLabel)
        contentView.addSubview(modeSwitch)

        modeLabel.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         paddingTop: 10, paddingLeft: 10, height: 30)

        modeSwitch.anchor(top: modeLabel.bottomAnchor,
                          paddingTop: 10)
        modeSwitch.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
