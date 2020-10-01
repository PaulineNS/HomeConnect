//
//  UpdateProfileDataSource.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import UIKit

final class UpdateProfileDataSource: NSObject {

    // MARK: - Public properties

    var arrayOfCells: [String] = []
    let textFieldTypeData = ["Prénom :",
                             "Nom :",
                             "N° de rue :",
                             "Nom de Rue :",
                             "Code Postal :",
                             "Ville :",
                             "Pays :"]

    // MARK: - Private properties

    private var users: [UserItem] = []

    // MARK: - Public Methods

    func updateCell(with users: [UserItem]) {
        self.users = users
    }

    func initViewModel(completion: @escaping (UpdateProfileCellViewModel) -> Void) {
        guard let user = users.first else {
            return
        }
        guard let userFirstName = user.firstName,
              let userLastName = user.lastName,
              let userStreetCode = user.streetCode,
              let userStreetName = user.street,
              let userPostalCode = user.postalCode,
              let userCity = user.city,
              let userCountry = user.country else {
            return
        }

        let viewModel = UpdateProfileCellViewModel(user: .init(firstName: userFirstName,
                                                               lastName: userLastName,
                                                               streetNumber: userStreetCode,
                                                               streetName: userStreetName,
                                                               postalCode: userPostalCode,
                                                               city: userCity,
                                                               country: userCountry))
        completion(viewModel)
    }
}

extension UpdateProfileDataSource: UITableViewDelegate,
                                   UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return textFieldTypeData.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell( withIdentifier: UpdateProfileTableViewCell.identifier,
                                                        for: indexPath) as? UpdateProfileTableViewCell,
            textFieldTypeData.indices.contains(indexPath.row)
        else {
            return UITableViewCell()
        }
        initViewModel { viewModel in
            cell.configure(with: viewModel)
        }
        cell.informationTypeLabel.text =  textFieldTypeData[indexPath.row]
        cell.dataTextField.text = cell.userInformationsArray[indexPath.row]
        arrayOfCells.append(cell.dataTextField.text ?? "")
        cell.dataTextField.tag = indexPath.row
        cell.dataTextField.delegate = self
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension UpdateProfileDataSource: UITextFieldDelegate {

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }

    // MARK: - Selector

    @objc func valueChanged(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldData.firstNameTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.lastNameTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.streetNumberTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.streetNameTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.postalCodeTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.cityTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        case TextFieldData.countryTextField.rawValue:
            arrayOfCells[textField.tag] = textField.text ?? ""
        default:
            break
        }
    }

}
