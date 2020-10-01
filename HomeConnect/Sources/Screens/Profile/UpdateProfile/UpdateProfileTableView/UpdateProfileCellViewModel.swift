//
//  UpdateProfileCellViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

struct UpdateProfileCellViewModel {

    // MARK: - Properties

    struct VisibleUser {
        let firstName: String
        let lastName: String
        let streetNumber: String
        let streetName: String
        let postalCode: Int
        let city: String
        let country: String
    }

    private let user: VisibleUser

    // MARK: - Init

    init(user: VisibleUser) {
        self.user = user
    }

    // MARK: - Outputs

    var userInformations: (([String]) -> Void)?

    // MARK: - Inputs

    func didUpdateCell() {
        userInformations?(getUserInformations())
    }

    func getUserInformations() -> [String] {
        var userInformations: [String] = []
        userInformations.append(user.firstName)
        userInformations.append(user.lastName)
        userInformations.append(user.streetNumber)
        userInformations.append(user.streetName)
        userInformations.append(String(user.postalCode))
        userInformations.append(user.city)
        userInformations.append(user.country)
        return userInformations
    }
}
