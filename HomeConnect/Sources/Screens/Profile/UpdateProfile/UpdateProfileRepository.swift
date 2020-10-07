//
//  UpdateProfileRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol UpdateProfileRepositoryType {

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void)
    func updateUser(userItem: UserItem,
                    birthdate: String)
}

final class UpdateProfileRepository: UpdateProfileRepositoryType {

    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init(dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - UpdateProfileRepositoryType

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void) {
        let users = dataBaseEngine.user
        let userItem = users.compactMap {
            UserItem(user: $0)
        }
        completion(userItem)
    }

    func updateUser(userItem: UserItem,
                    birthdate: String) {
        dataBaseEngine.updateUserEntity(userItem: userItem,
                                        birthdate: birthdate)
    }

}
