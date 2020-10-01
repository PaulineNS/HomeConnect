//
//  MockLightRepository.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockLightRepository: LightRepositoryType {

    let dataBaseEngine = DataBaseEngine(dataBaseStack: MockDataBaseStack())

    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    func deleteDevice(with deviceId: String) {
        deviceItem = []
        dataBaseEngine.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String, mode: String, intensity: String) {
        dataBaseEngine.updateDeviceEntity(for: deviceId, mode: mode, intensity: intensity)
    }
}
