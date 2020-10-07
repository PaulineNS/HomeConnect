//
//  MockFilterRepository.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class MockFilterRepository: FiltersRepositoryType {

    let dataBaseEngine = DataBaseEngine(dataBaseStack: MockDataBaseStack())

    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    func searchDevice(productType: String,
                      mode: String?,
                      settings: String,
                      settingsValue: String,
                      completion: @escaping ([DeviceItem]) -> Void) {

        let device = dataBaseEngine.fetchDevicesWithFilters(productType: productType,
                                                            mode: mode,
                                                            settings: settings,
                                                            settingsValue: settingsValue)
        guard let deviceAttribute =  device.first else {
            let deviceItem: [DeviceItem] = []
            completion(deviceItem)
            return
        }
        let deviceItem = DeviceItem(device: deviceAttribute)!
        completion([deviceItem])
    }

}
