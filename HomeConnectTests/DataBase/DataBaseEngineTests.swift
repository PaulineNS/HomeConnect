//
//  DataBaseEngineTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

@testable import HomeConnect
import XCTest

// MARK: - Tests

final class DataBaseEngineTests: XCTestCase {

    // MARK: - Variables

    var dataBaseStack: MockDataBaseStack!
    var dataBaseEngine: DataBaseEngine!
    let deviceMock = DeviceMock()

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        dataBaseStack = MockDataBaseStack()
        dataBaseEngine = DataBaseEngine(dataBaseStack: dataBaseStack)
    }

    override func tearDown() {
        super.tearDown()
        dataBaseEngine = nil
        dataBaseStack = nil
    }

    // MARK: - Tests

    func testCreateNewDevice_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        dataBaseEngine.createDeviceEntity(deviceItem: DeviceItem(device: deviceMock)!)
        XCTAssertTrue(!dataBaseEngine.devices.isEmpty)
        XCTAssertTrue(dataBaseEngine.devices.count == 1)
        XCTAssertTrue(dataBaseEngine.devices[0].name! == "light-kitchen")
    }

    func testCreateNewUser_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        dataBaseEngine.createUserEntity(userItem: UserItem(firstName: "Pauline",
                                                            lastName: "Nomballais",
                                                            birthDate: "100591",
                                                            city: "Paris",
                                                            postalCode: 75001,
                                                            street: "Paris",
                                                            streetCode: "44",
                                                            country: "France"))
        XCTAssertTrue(!dataBaseEngine.user.isEmpty)
        XCTAssertTrue(dataBaseEngine.user.count == 1)
        XCTAssertTrue(dataBaseEngine.user[0].firstName! == "Pauline")
    }

    func testDeleteADeviceMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
        dataBaseEngine.createDeviceEntity(deviceItem: DeviceItem(device: deviceMock)!)
        dataBaseEngine.deleteADevice(with: "1")
        XCTAssertTrue(dataBaseEngine.devices.isEmpty)
    }

    func testUpdateDevice_WhenAnEntityIsUpdated_ThenShouldBeCorrectlySaved() {
        dataBaseEngine.createDeviceEntity(deviceItem: DeviceItem(device: deviceMock)!)
        dataBaseEngine.updateDeviceEntity(for: "1",
                                           mode: "ON",
                                           position: "100",
                                           intensity: "200",
                                           temperature: "10")
        XCTAssertTrue(dataBaseEngine.devices[0].mode! == "ON")
        XCTAssertTrue(dataBaseEngine.devices[0].intensity! == "200")
        XCTAssertTrue(dataBaseEngine.devices[0].temperature! == "10")
        XCTAssertTrue(dataBaseEngine.devices[0].position! == "100")
    }

    func testUpdateUser_WhenAnEntityIsUpdated_ThenShouldBeCorrectlySaved() {
        dataBaseEngine.createUserEntity(userItem: UserItem(firstName: "Pauline",
                                                            lastName: "Nomballais",
                                                            birthDate: "100591",
                                                            city: "Paris",
                                                            postalCode: 75001,
                                                            street: "Paris",
                                                            streetCode: "44",
                                                            country: "France"))
        dataBaseEngine.createUserEntity(userItem: UserItem(firstName: "Pierre",
                                                            lastName: "Paul",
                                                            birthDate: "11000",
                                                            city: "Nantes",
                                                            postalCode: 44000,
                                                            street: "Rue Jean Paul",
                                                            streetCode: "12",
                                                            country: "Italie"))
        XCTAssertTrue(dataBaseEngine.user[0].city! == "Nantes")
        XCTAssertTrue(dataBaseEngine.user[0].country! == "Italie")
        XCTAssertTrue(dataBaseEngine.user[0].firstName! == "Pierre")
        XCTAssertTrue(dataBaseEngine.user[0].lastName! == "Paul")
        XCTAssertTrue(dataBaseEngine.user[0].postalCode! == "44000")
        XCTAssertTrue(dataBaseEngine.user[0].street! == "Rue Jean Paul")
        XCTAssertTrue(dataBaseEngine.user[0].streetCode! == "12")
    }

}

struct DeviceMock {
    let deviceId: String = "1"
    let deviceName: String = "light-kitchen"
    let intensity: Int = 10
    let mode: String = "ON"
    var productType: String = "Light"
    let position: Int = 10
    let temperature: Int = 10
}

// MARK: - ProductType

extension DeviceItem {
    init?(device: DeviceMock) {
        self.init(idNumber: device.deviceId,
                  deviceName: device.deviceName,
                  productType: ProductType(device: device)!)

    }
}

extension ProductType {
    init?(device: DeviceMock) {
        switch device.productType {
        case "Heater":
                let mode = device.mode
            let temperature = device.temperature
            self = .heater(mode: mode, temperature: "\(temperature)")
        case "Light":
            let mode = device.mode
            let intensity = device.intensity
        self = .light(mode: mode, intensity: "\(intensity)")
        case "RollerShutter":
            let position = device.position
        self = .rollerShutter(position: "\(position)")
        default: return nil
        }
    }
}
