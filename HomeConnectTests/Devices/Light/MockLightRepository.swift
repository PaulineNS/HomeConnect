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

    let dataBaseManager = DataBaseManager(dataBaseStack: MockDataBaseStack())

    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    func deleteDevice(with deviceId: String) {
        deviceItem = []
        dataBaseManager.deleteADevice(with: deviceId)
    }

    func updateDevice(with deviceId: String, mode: String, intensity: String) {
        dataBaseManager.updateDeviceEntity(for: deviceId, mode: mode, intensity: intensity)
    }
}
