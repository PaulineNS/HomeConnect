//
//  UpdateProfileViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

final class UpdateProfileViewModel {

    // MARK: - Private properties

    private let repository: UpdateProfileRepositoryType
    private weak var delegate: UpdateProfileScreensDelegate?

    private var user: [UserItem] = [] {
        didSet {
            guard !user.isEmpty else {
                delegate?.updateProfileScreenShouldDisplayAlert(for: .noUserError)
                return
            }
        userDisplayed?(user)
        }
    }

    // MARK: - Init

    init(repository: UpdateProfileRepositoryType,
         delegate: UpdateProfileScreensDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var userDisplayed: (([UserItem]) -> Void)?
    var saveIconName: ((String) -> Void)?

    // MARK: - Life cycle

    func start() {
        getUser()
        saveIconName?("save_button".localized)
    }

    // MARK: - Inputs

    private func getUser() {
        repository.fetchPersistenceUser { users in
            self.user = users
        }
    }

    func saveNewUserInformations(with newInformations: [String]) {
        let userItem = UserItem(user: newInformations)
        repository.updateUser(userItem: userItem,
                              birthdate: user.first?.birthDate ?? "")
        self.delegate?.updateProfileScreenDidSelectSaveButton()
    }
}

private extension UserItem {
    init(user: [String]) {
        self.firstName = user[0]
        self.lastName = user[1]
        self.city = user[5]
        self.postalCode = Int(user[4])
        self.street = user[3]
        self.streetCode = user[2]
        self.country = user[6]
        self.birthDate = ""
    }
}
