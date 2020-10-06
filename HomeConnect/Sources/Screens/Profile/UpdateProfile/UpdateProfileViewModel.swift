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

    func saveNewUserInformations(with newInformatiosn: [String]) {
        repository.updateUser(firstName: newInformatiosn[0],
                              lastName: newInformatiosn[1],
                              streetNumber: newInformatiosn[2],
                              streetName: newInformatiosn[3],
                              postalCode: newInformatiosn[4],
                              city: newInformatiosn[5],
                              country: newInformatiosn[6],
                              birthdate: user.first?.birthDate ?? "")
        self.delegate?.updateProfileScreenDidSelectSaveButton()
    }
}
