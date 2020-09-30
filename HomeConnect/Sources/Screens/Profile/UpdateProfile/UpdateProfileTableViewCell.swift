//
//  UpdateProfileTableViewCell.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import UIKit

class UpdateProfileTableViewCell: UITableViewCell {

    static let identifier = "UpdateProfileTableViewCell"
    private var viewModel: UpdateProfileCellViewModel!
    var userInformationsArray: [String] = []

    lazy var informationTypeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()

    // MARK: - Public Methods

    func configure(with viewModel: UpdateProfileCellViewModel) {
        configure()
        self.viewModel = viewModel
        bindViewModel()
        self.viewModel.didUpdateCell()
    }

    // MARK: - Private Methods

    private func bindViewModel() {
        viewModel.userInformations = { [weak self] user in
            self?.userInformationsArray = user
        }

    }

    public func configure() {
        contentView.addSubview(dataTextField)
        contentView.addSubview(informationTypeLabel)
        informationTypeLabel.anchor(top: contentView.topAnchor,
                                    left: contentView.leftAnchor,
                                    bottom: contentView.bottomAnchor,
                                    paddingLeft: 15,
                                    width: 150)
        dataTextField.anchor(top: contentView.topAnchor,
                             left: informationTypeLabel.rightAnchor,
                             bottom: contentView.bottomAnchor,
                             paddingTop: 10,
                             paddingLeft: 10)
    }

}
