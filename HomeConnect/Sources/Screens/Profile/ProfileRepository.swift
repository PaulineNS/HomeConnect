//
//  HomeRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

protocol ProfileRepositoryType: class {

    func getUserInformations() -> UserAttributes

}

final class ProfileRepository: ProfileRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    func getUserInformations() -> UserAttributes {
        guard let user = dataBaseManager.users.first else { return UserAttributes()}
        return user
    }

}
