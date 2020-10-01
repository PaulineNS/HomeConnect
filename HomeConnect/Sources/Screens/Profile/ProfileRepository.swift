//
//  HomeRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

protocol ProfileRepositoryType: class {

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void)
}

final class ProfileRepository: ProfileRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void) {
        let users = dataBaseManager.user
        let userItem = users.compactMap {
            UserItem(user: $0)
        }
        completion(userItem)
    }
}

private extension UserItem {
    init(user: UserAttributes) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthDate = user.birthDate
        self.city = user.city
        self.postalCode = Int(user.postalCode ?? "")
        self.street = user.street
        self.streetCode = user.streetCode
        self.country = user.country
    }
}
