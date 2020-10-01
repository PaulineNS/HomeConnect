//
//  HomeRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockHomeUserDefaultChecker: UserDefaultsType {
    func bool(forKey defaultName: String) -> Bool {
        false
    }

    func set(_ value: Bool, forKey defaultName: String) {
        print("")
    }
}

// MARK: - Tests

class HomeRepositoryTests: XCTestCase {

    let client = MockHTTPClient()

    let deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]
    let userItem = UserItem(firstName: "Pauline",
                             lastName: "Nomballais",
                             birthDate: "100591",
                             city: "Paris",
                             postalCode: 75001,
                             street: "Paris",
                             streetCode: "44",
                             country: "France")

    func test_Given_HomeRepository_When_getUserDevices_Then_DataIsCorrectlyReturned() {

        let repository = HomeRepository(networkClient: client,
                                        token: RequestCancellationToken(),
                                        dependanceType: DependanceType.network,
                                        dataBaseManager: DataBaseManager(
                                            dataBaseStack: DataBaseStack(
                                                modelName: "HomeConnect")
                                        ),
                                        checker: UserDefaultChecker(userdefault: MockHomeUserDefaultChecker()))
        repository.getUserDevices { (deviceItem, _) in
            XCTAssertEqual("\(deviceItem[0].idNumber)", self.deviceItem[0].idNumber)
        } failure: {
            print("error")
        } completion: { deviceItem in
            print(deviceItem)
        }
    }
}
