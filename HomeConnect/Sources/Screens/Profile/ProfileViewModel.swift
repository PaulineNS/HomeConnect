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
    private weak var delegate: ProfileScreenDelegate?
    private var user: [UserItem] = [] {
        didSet {
            profileImageName?("light")
            userName?("\(user.first?.firstName ?? "") \(user.first?.lastName ?? "")")
            userAge?("29 ans")
            userStreet?("\(user.first?.streetCode ?? ""), \(user.first?.street ?? "")")
            userCity?("44, \(user.first?.city ?? "")")
            userCountry?("\(user.first?.country ?? "")")
        }
    }

    // MARK: - Initializer

    init(repository: ProfileRepositoryType,
         delegate: ProfileScreenDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var userDisplayed: ((UserItem) -> Void)?
    var profileImageName: ((String) -> Void)?
    var userName: ((String) -> Void)?
    var userAge: ((String) -> Void)?
    var userStreet: ((String) -> Void)?
    var userCity: ((String) -> Void)?
    var userCountry: ((String) -> Void)?

    // MARK: - Life cycle

    func viewWillAppear() {
        getUser()
    }

    private func getUser() {
        repository.fetchPersistenceUser { users in
            self.user = users
        }
    }

    func didSelectUpdateProfileButton() {
        delegate?.profileScreenDidSelectUpdateProfileButton()
    }

}
