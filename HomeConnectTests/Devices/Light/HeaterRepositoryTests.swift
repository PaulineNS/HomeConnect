//
//  HeaterRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class HeaterRepositoryTests: XCTestCase {

    var databaseEngine: DataBaseEngine!
    var repository: HeaterRepository!

    override func setUp() {
        super.setUp()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        repository = HeaterRepository(dataBaseEngine: databaseEngine)
    }

    func test_GivenALightRepository_WhenDeleteDevice_ThenDeviceIsDeleted() {

        let deviceItemsToSave = mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! }
        deviceItemsToSave?.forEach {
            databaseEngine.createDeviceEntity(deviceItem: $0)
        }
        repository.deleteItem(with: "1")

        XCTAssertEqual(databaseEngine.devices.count, 11)

    }

    func test_GivenARollerShutterRepository_WhenUpdtaeDevice_ThenDeviceIsUpdated() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "Heater"
        let deviceItem = DeviceItem(device: deviceMock)!

        databaseEngine.createDeviceEntity(deviceItem: deviceItem)

        repository.updateDevice(with: "1", mode: "ON", temperature: "20")

        XCTAssertEqual(databaseEngine.devices[0].temperature, "20")
        XCTAssertEqual(databaseEngine.devices[0].mode, "ON")

    }

}
