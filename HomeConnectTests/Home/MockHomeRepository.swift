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

    var deviceItem: [DeviceItem]?
    var userItem: UserItem?

    var isSuccess = true
    var error: Error?

    func getUserDevices(success: @escaping ([DeviceItem], UserItem) -> Void,
                        failure: @escaping (() -> Void),
                        completion: @escaping ([DeviceItem]) -> Void) {
        if isSuccess {
            guard let deviceItem = deviceItem, let userItem = userItem else { return }
            success(deviceItem, userItem)
        } else {
            failure()
        }
    }
}
