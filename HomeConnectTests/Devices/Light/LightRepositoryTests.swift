//
//  LightRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class LightRepositoryTests: XCTestCase {

    var databaseEngine: DataBaseEngine!
    var repository: LightRepository!

    override func setUp() {
        super.setUp()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        repository = LightRepository(dataBaseEngine: databaseEngine)
    }

    func test_GivenALightRepository_WhenDeleteDevice_ThenDeviceIsDeleted() {

        let deviceItemsToSave = mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! }
        deviceItemsToSave?.forEach {
            databaseEngine.createDeviceEntity(deviceItem: $0)
        }
        repository.deleteDevice(with: "1")

        XCTAssertEqual(databaseEngine.devices.count, 11)

    }

    func test_GivenALightRepository_WhenUpdtaeDevice_ThenDeviceIsUpdated() {

        let deviceItem = DeviceItem(device: DeviceMock())
        databaseEngine.createDeviceEntity(deviceItem: deviceItem!)

        repository.updateDevice(with: "1", mode: "OFF", intensity: "0")

        XCTAssertEqual(databaseEngine.devices[0].mode, "OFF")
        XCTAssertEqual(databaseEngine.devices[0].intensity, "0")

    }

}
