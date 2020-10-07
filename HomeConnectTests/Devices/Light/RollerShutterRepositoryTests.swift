//
//  RollerShutterRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class RollerShutterRepositoryTests: XCTestCase {

    var databaseEngine: DataBaseEngine!
    var repository: RollerShutterRepository!

    override func setUp() {
        super.setUp()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        repository = RollerShutterRepository(dataBaseEngine: databaseEngine)
    }

    func test_GivenALightRepository_WhenDeleteDevice_ThenDeviceIsDeleted() {

        let deviceItemsToSave = mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! }
        deviceItemsToSave?.forEach {
            databaseEngine.createDeviceEntity(deviceItem: $0)
        }
        repository.deleteDevice(with: "1")

        XCTAssertEqual(databaseEngine.devices.count, 11)

    }

    func test_GivenARollerShutterRepository_WhenUpdtaeDevice_ThenDeviceIsUpdated() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItem = DeviceItem(device: deviceMock)!

        databaseEngine.createDeviceEntity(deviceItem: deviceItem)

        repository.updateDevice(with: "1", position: "30")

        XCTAssertEqual(databaseEngine.devices[0].position, "30")

    }

}
