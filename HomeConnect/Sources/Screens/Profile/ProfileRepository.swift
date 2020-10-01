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

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init( dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - ProfileRepositoryType

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void) {
        let users = dataBaseEngine.user
        let userItem = users.compactMap {
            UserItem(user: $0)
        }
        completion(userItem)
    }
}
