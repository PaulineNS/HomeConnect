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
    weak var delegate: ModeFilterTableViewCellDelegate?

    // MARK: - Private Properties

    private let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "mode_filter".localized
        return label
    }()

    private lazy var modeStackView: UIStackView = {
        let stackView = UIStackView()
        modeSwitch.onTintColor = #colorLiteral(red: 0.307313025, green: 0.70265311, blue: 0.7067130804, alpha: 1)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.addArrangedSubview(modeOffLabel)
        stackView.addArrangedSubview(modeSwitch)
        stackView.addArrangedSubview(modeOnLabel)
        return stackView
    }()

    let modeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        return mySwitch
    }()

    private lazy var modeOnLabel: UILabel = {
        let label = UILabel()
        label.text = "on_status".localized
        label.textAlignment = .center
        return label
    }()

    private lazy var modeOffLabel: UILabel = {
        let label = UILabel()
        label.text = "off_status".localized
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

    @objc func didChangeSwitchValue() {
        delegate?.didChangeModeSwitchValue(to: modeSwitch.isOn)
    }
}

protocol ModeFilterTableViewCellDelegate: class {
    func didChangeModeSwitchValue(to value: Bool)
}
