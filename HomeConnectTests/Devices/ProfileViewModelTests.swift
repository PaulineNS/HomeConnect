//
//  ProfileViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mock

class MockProfileScreenDelegate: ProfileScreenDelegate {

    var didShowUpdateProfileView = false
    var didLeaveTheView = false

    func profileScreenDidSelectUpdateProfileButton() {
        didShowUpdateProfileView = true
    }

    func profileScreenDidSelectCloseButton() {
        didLeaveTheView = true
    }

}

// MARK: - Tests

class ProfileViewModelTests: XCTestCase {

    let userItem = UserItem(firstName: "Pauline",
                             lastName: "Nomballais",
                             birthDate: "100591",
                             city: "Paris",
                             postalCode: 75001,
                             street: "Paris",
                             streetCode: "44",
                             country: "France")

    let repository = MockProfileRepository()

    let delegate = MockProfileScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let viewModel = ProfileViewModel(repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed profileImageName")
        let expectation1 = self.expectation(description: "Diplayed userName")
        let expectation2 = self.expectation(description: "Diplayed userAge")
        let expectation3 = self.expectation(description: "Diplayed userStreet")
        let expectation4 = self.expectation(description: "Diplayed userCity")
        let expectation5 = self.expectation(description: "Diplayed userCountry")

        viewModel.profileImageName = { name in
            XCTAssertEqual(name, "profilePicture")
            expectation0.fulfill()
        }
        viewModel.userName = { name in
            XCTAssertEqual(name, "\(self.userItem.firstName ?? "") \(self.userItem.lastName ?? "")")
            expectation1.fulfill()
        }
        viewModel.userAge = { age in
            XCTAssertEqual(age, "Né le : \(self.userItem.birthDate ?? "")")
            expectation2.fulfill()
        }
        viewModel.userStreet = { street in
            XCTAssertEqual(street, "\(self.userItem.streetCode ?? ""), \(self.userItem.street ?? "")")
            expectation3.fulfill()
        }
        viewModel.userCity = { city in
            XCTAssertEqual(city, "\(self.userItem.postalCode ?? 0), \(self.userItem.city ?? "")")
            expectation4.fulfill()
        }
        viewModel.userCountry = { country in
            XCTAssertEqual(country, self.userItem.country)
            expectation5.fulfill()
        }

        viewModel.viewWillAppear()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didSelectUpdtaeProfileButton_Then_ShowViewController() {

        let viewModel = ProfileViewModel(repository: repository, delegate: delegate)

        viewModel.viewWillAppear()
        viewModel.didSelectUpdateProfileButton()

        XCTAssertEqual(delegate.didShowUpdateProfileView, true)
    }

}
