//
//  LightRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol LightRepositoryType {
    func deleteDevice(with deviceId: String)
    func updateDevice(with deviceId: String, mode: String, intensity: String)
}

final class LightRepository: LightRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - LightRepositoryType

    func deleteDevice(with deviceId: String) {
        dataBaseManager.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String, mode: String, intensity: String) {
        dataBaseManager.updateDeviceEntity(for: deviceId,
                                           mode: mode,
                                           intensity: intensity)
    }

}
