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
            guard let userBirthDate = user.first?.birthDate else {return}
            profileImageName?("profilePicture")
            userName?("\(user.first?.firstName ?? "") \(user.first?.lastName ?? "")")
            userAge?("profile_birth_date_title".localized + "\(userBirthDate)")
            userStreet?("\(user.first?.streetCode ?? ""), \(user.first?.street ?? "")")
            userCity?("\(user.first?.postalCode ?? 0), \(user.first?.city ?? "")")
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

    var profileImageName: ((String) -> Void)?
    var userName: ((String) -> Void)?
    var userAge: ((String) -> Void)?
    var userStreet: ((String) -> Void)?
    var userCity: ((String) -> Void)?
    var userCountry: ((String) -> Void)?
    var updateIconName: ((String) -> Void)?
    var closeIconName: ((String) -> Void)?

    // MARK: - Life cycle

    func viewWillAppear() {
        getUser()
    }

    func viewDidLoad() {
        updateIconName?("update_profile".localized)
        closeIconName?("crossClose")
    }

    // MARK: - Inputs

    func didSelectUpdateProfileButton() {
        delegate?.profileScreenDidSelectUpdateProfileButton()
    }

    func didSelectCrossButton() {
        delegate?.profileScreenDidSelectCloseButton()
    }

    // MARK: - Privates Methods

    private func getUser() {
        repository.fetchPersistenceUser { users in
            self.user = users
        }
    }

}
