//
//  LightRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol LightRepositoryType {
    func deleteDevice(with deviceId: String)
    func updateDevice(with deviceId: String,
                      mode: String,
                      intensity: String)
}

final class LightRepository: LightRepositoryType {

    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init( dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - LightRepositoryType

    func deleteDevice(with deviceId: String) {
        dataBaseEngine.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String,
                      mode: String,
                      intensity: String) {
        dataBaseEngine.updateDeviceEntity(for: deviceId,
                                           mode: mode,
                                           intensity: intensity)
    }

}
