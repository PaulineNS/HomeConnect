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
    private var user: UserAttributes = UserAttributes() {
        didSet {
            profileImageName?("light")
            userName?("\(user.firstName ?? "") \(user.lastName ?? "")")
            userAge?("29 ans")
            userStreet?("\(user.streetCode ?? ""), \(user.street ?? "")")
            userCity?("\(user.postalCode ?? ""), \(user.city ?? "")")
            userCountry?("\(user.country ?? "")")
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
        user = repository.getUserInformations()
    }

    func viewDidLoad() {

    }

    func didSelectUpdateProfileButton() {
        delegate?.profileScreenDidSelectUpdateProfileButton()
    }

}
