//
//  RollerShutterRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol RollerShutterRepositoryType {
    func deleteDevice(with deviceId: String)
    func updateDevice(with deviceId: String, position: String)
}

final class RollerShutterRepository: RollerShutterRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - RollerShutterRepositoryType

    func deleteDevice(with deviceId: String) {
        dataBaseManager.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String, position: String) {
        dataBaseManager.updateDeviceEntity(for: deviceId, position: position)
    }

}
