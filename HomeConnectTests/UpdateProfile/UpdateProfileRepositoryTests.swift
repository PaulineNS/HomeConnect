//
//  UpdateProfileRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@testable import HomeConnect

class UpdateProfileRepositoryTests: XCTestCase {

    var databaseEngine: DataBaseEngine!
    var repository: UpdateProfileRepository!

    override func setUp() {
        super.setUp()
        databaseEngine = DataBaseEngine(
            dataBaseStack: MockDataBaseStack()
        )
        repository = UpdateProfileRepository(dataBaseEngine: databaseEngine)
    }

    func test_GivenAnUpdateProfileRepository_WhenFetchUser_ThenUserIsFetched() {

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

    func test_GivenAnUpdateProfileRepository_WhenUpdateUser_ThenUserIsUpdated() {

        let userItemToSave = UserItem(firstName: "pauline",
                                      lastName: "nomballais",
                                      birthDate: "10051991",
                                      city: "Paris",
                                      postalCode: 75011,
                                      street: "rue",
                                      streetCode: "11",
                                      country: "France")

        databaseEngine.createUserEntity(userItem: userItemToSave)
        repository.updateUser(userItem: UserItem(firstName: "dédé",
                                                           lastName: "bibi",
                                                           birthDate: "1103",
                                                           city: "Nantes",
                                                           postalCode: 44000,
                                                           street: "street",
                                                           streetCode: "02",
                                                           country: "Italie"),
                                        birthdate: "1111")

        XCTAssertEqual(databaseEngine.user[0].firstName, "dédé")
        XCTAssertEqual(databaseEngine.user[0].lastName, "bibi")
        XCTAssertEqual(databaseEngine.user[0].birthDate, "1111")
        XCTAssertEqual(databaseEngine.user[0].city, "Nantes")
        XCTAssertEqual(databaseEngine.user[0].country, "Italie")
        XCTAssertEqual(databaseEngine.user[0].postalCode, "44000")
        XCTAssertEqual(databaseEngine.user[0].street, "street")
        XCTAssertEqual(databaseEngine.user[0].streetCode, "02")

    }

}
