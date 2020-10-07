//
//  MockUpdateProfileRepository.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class MockUpdateProfileRepository: UpdateProfileRepositoryType {

    let dataBaseEngine = DataBaseEngine(dataBaseStack: MockDataBaseStack())

    let userItem = UserItem(firstName: "Pauline",
                             lastName: "Nomballais",
                             birthDate: "100591",
                             city: "Paris",
                             postalCode: 75001,
                             street: "Paris",
                             streetCode: "44",
                             country: "France")

    var deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    func fetchPersistenceUser(completion: @escaping ([UserItem]) -> Void) {
        completion([userItem])
    }

    func updateUser(userItem: UserItem, birthdate: String) {
        dataBaseEngine.updateUserEntity(userItem: userItem, birthdate: "1005")
    }

}
