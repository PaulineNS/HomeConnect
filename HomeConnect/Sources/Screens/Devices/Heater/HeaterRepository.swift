//
//  HeaterRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol HeaterRepositoryType {
    func deleteItem(with deviceId: String)
    func updateDevice(with deviceId: String,
                      mode: String,
                      temperature: String)

}

final class HeaterRepository: HeaterRepositoryType {

    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init( dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - HeaterRepositoryType

    func deleteItem(with deviceId: String) {
        dataBaseEngine.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String,
                      mode: String,
                      temperature: String) {
        dataBaseEngine.updateDeviceEntity(for: deviceId,
                                           mode: mode,
                                           temperature: temperature)
    }

}
