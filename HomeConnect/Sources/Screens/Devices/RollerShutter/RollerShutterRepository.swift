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

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init( dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - RollerShutterRepositoryType

    func deleteDevice(with deviceId: String) {
        dataBaseEngine.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String, position: String) {
        dataBaseEngine.updateDeviceEntity(for: deviceId, position: position)
    }

}
