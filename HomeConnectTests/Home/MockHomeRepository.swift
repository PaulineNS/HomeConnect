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

    var deviceItem: [DeviceItem] = []
    var isSuccess = true
    var error: Error!

    func getDevices(callback: @escaping (Result<[DeviceItem], Error>) -> Void) {
        if isSuccess {
            callback(.success(deviceItem))
        } else {
            callback(.failure(error))
        }
    }
}
