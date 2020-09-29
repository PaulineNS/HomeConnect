//
//  RollerShutterRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol RollerShutterRepositoryType {
    func deleteItem(with deviceId: String)
}

final class RollerShutterRepository: RollerShutterRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - RollerShutterRepositoryType

    func deleteItem(with deviceId: String) {
        dataBaseManager.deleteADevice(with: deviceId)
    }

}
