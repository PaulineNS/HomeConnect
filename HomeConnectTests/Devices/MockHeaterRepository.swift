//
//  MockHeaterRepository.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockHeaterRepository: HeaterRepositoryType {
    
    let dataBaseManager = DataBaseManager(dataBaseStack: MockDataBaseStack())
    
    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]
    
    func deleteItem(with deviceId: String) {
        deviceItem = []
        dataBaseManager.deleteADevice(with: deviceId)
    }
    
    func updateDevice(with deviceId: String, mode: String, temperature: String) {
        dataBaseManager.updateDeviceEntity(for: deviceId, mode: mode, temperature: temperature)
    }
    
}

