//
//  UpdateProfileRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol UpdateProfileRepositoryType {

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void)
    func updateUser(firstName: String,
                    lastName: String,
                    streetNumber: String,
                    streetName: String,
                    postalCode: String,
                    city: String,
                    country: String,
                    birthdate: String)
}

final class UpdateProfileRepository: UpdateProfileRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    func getUserInformations() -> [UserAttributes] {

        return dataBaseManager.user
    }

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void) {
        let users = dataBaseManager.user
        let userItem = users.compactMap {
            UserItem(user: $0)
        }
        completion(userItem)
    }

    func updateUser(firstName: String,
                    lastName: String,
                    streetNumber: String,
                    streetName: String,
                    postalCode: String,
                    city: String,
                    country: String,
                    birthdate: String) {
        dataBaseManager.updateUserEntity(firstName: firstName,
                                         lastName: lastName,
                                         streetNumber: streetNumber,
                                         streetName: streetName,
                                         postalCode: postalCode,
                                         city: city,
                                         country: country,
                                         birthdate: birthdate)
    }

}
