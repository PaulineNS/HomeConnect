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
