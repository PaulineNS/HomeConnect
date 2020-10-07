//
//  ProfileRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class ProfileRepositoryTests: XCTestCase {

    var databaseEngine: DataBaseEngine!
    var repository: ProfileRepository!

    override func setUp() {
        super.setUp()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        repository = ProfileRepository(dataBaseEngine: databaseEngine)
    }

    func test_GivenAProfileRepository_WhenFetchUser_ThenUserIsFetched() {

        let userItemToSave = UserItem(firstName: "pauline",
                                      lastName: "nomballais",
                                      birthDate: "10051991",
                                      city: "Paris",
                                      postalCode: 75011,
                                      street: "rue",
                                      streetCode: "11",
                                      country: "France")

        databaseEngine.createUserEntity(userItem: userItemToSave)

        let expectation = self.expectation(description: "Returned userItems")

        repository.fetchPersistenceUser { result in
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result[0].firstName, "pauline")
            XCTAssertEqual(result[0].lastName, "nomballais")
            XCTAssertEqual(result[0].city, "Paris")
            XCTAssertEqual(result[0].postalCode, 75011)
            XCTAssertEqual(result[0].street, "rue")
            XCTAssertEqual(result[0].streetCode, "11")
            XCTAssertEqual(result[0].country, "France")

            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)

    }
}
