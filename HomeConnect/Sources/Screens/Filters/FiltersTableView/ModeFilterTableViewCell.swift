//
//  ModeFilterTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import UIKit

final class ModeFilterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let identifier = "ModeFilterTableViewCell"

    // MARK: - Private Properties

    private let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode :"
        return label
    }()

    private lazy var modeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.addArrangedSubview(modeOffLabel)
        stackView.addArrangedSubview(modeSwitch)
        stackView.addArrangedSubview(modeOnLabel)
        return stackView
    }()

    private let modeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        return mySwitch
    }()

    private lazy var modeOnLabel: UILabel = {
        let label = UILabel()
        label.text = "On"
        label.textAlignment = .center
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.text = "Off"
        label.textAlignment = .center
        return label
    }()

    // MARK: - Public Methods

    public func configure() {
        contentView.addSubview(modeLabel)
        contentView.addSubview(modeStackView)

        modeLabel.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         paddingTop: 10, paddingLeft: 10, height: 30)
        modeStackView.anchor(top: modeLabel.bottomAnchor,
                          paddingTop: 10)
        modeStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
