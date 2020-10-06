//
//  HomeRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockHomeUserDefaultChecker: UserDefaultCheckerType {

    var alreadyBeenLaunched = false

    func hasAlreadyBeenLaunched() -> Bool {
        return alreadyBeenLaunched
    }
}

// MARK: - Tests

class HomeRepositoryTests: XCTestCase {

    var client: MockHTTPClient!
    var databaseEngine: DataBaseEngine!
    var checker: MockHomeUserDefaultChecker!

    var repository: HomeRepository!

    override func setUp() {
        super.setUp()
        client = MockHTTPClient()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        checker = MockHomeUserDefaultChecker()
        repository = HomeRepository(
            networkClient: client,
            dataBaseEngine: databaseEngine,
            checker: checker
        )
    }

    func test_GivenAHomeRepository_WhenGetDevicesAndCheckerHasNeverBeenLaunchedBefore_ThenItReturnsNetworkResult() {
        checker.alreadyBeenLaunched = false
        client.response = mockDeviceResponse
        let expectation = self.expectation(description: "Returned deviceItems")

        let expectedResult: [DeviceItem] = (mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! })!

        repository.getDevices { result in
            if case .success(let deviceItems) = result {
                XCTAssertEqual(deviceItems, expectedResult)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_GivenAHomeRepository_WhenGetDevicesAndCheckerHasBeenLaunchedBefore_ThenItReturnsNetworkResult() {
        checker.alreadyBeenLaunched = true
        let deviceItemsToSave = mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! }
        deviceItemsToSave?.forEach {
            databaseEngine.createDeviceEntity(deviceItem: $0)
        }

        let expectation = self.expectation(description: "Returned deviceItems")

        repository.getDevices { result in
            if case .success(let deviceItems) = result {
                XCTAssertEqual(deviceItems.count, 12)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
