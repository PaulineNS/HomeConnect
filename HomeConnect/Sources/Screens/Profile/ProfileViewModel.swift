//
//  ProfileViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class ProfileViewModel {

    // MARK: - Private properties

    private let repository: ProfileRepositoryType
    private var user: UserItem {
            UserItem(firstName: "",
                     lastName: "",
                     birthDate: 1,
                     city: "",
                     postalCode: 1,
                     street: "",
                     streetCode: "",
                     country: "")
    }

    // MARK: - Initializer

    init(repository: ProfileRepositoryType) {
        self.repository = repository
    }

    // MARK: - Outputs

    var profileImageName: ((String) -> Void)?
    var userDisplayed: ((UserItem) -> Void)?

    // MARK: - Life cycle

    func viewWillAppear() {
    }

    func viewDidLoad() {
    }

    // MARK: - Methods

    private func getUserInformations() {

    }

}
