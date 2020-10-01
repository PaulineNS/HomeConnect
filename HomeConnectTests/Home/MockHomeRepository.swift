//
//  MockHomeRepository.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockHomeRepository: HomeRepositoryType {

    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]
    let userItem = UserItem(firstName: "Pauline",
                             lastName: "Nomballais",
                             birthDate: "100591",
                             city: "Paris",
                             postalCode: 75001,
                             street: "Paris",
                             streetCode: "44",
                             country: "France")

    var isSuccess = true
    var error: Error?

    func getUserDevices(success: @escaping ([DeviceItem], UserItem) -> Void,
                        failure: @escaping (() -> Void),
                        completion: @escaping ([DeviceItem]) -> Void) {
        if isSuccess {
            success(deviceItem, userItem)
        } else {
            failure()
        }
    }
}
