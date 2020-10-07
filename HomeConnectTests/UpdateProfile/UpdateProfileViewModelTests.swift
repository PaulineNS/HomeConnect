//
//  UpdateProfileViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mock

class MockUpdateProfileScreenDelegate: UpdateProfileScreensDelegate {

    var didLeaveTheView = false
    var alert: AlertType?

    func updateProfileScreenShouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }

    func updateProfileScreenDidSelectSaveButton() {
        didLeaveTheView = true
    }

}

// MARK: - Tests

class UpdateProfileViewModelTests: XCTestCase {

    let userItem = UserItem(firstName: "Pauline",
                             lastName: "Nomballais",
                             birthDate: "100591",
                             city: "Paris",
                             postalCode: 75001,
                             street: "Paris",
                             streetCode: "44",
                             country: "France")

    let repository = MockUpdateProfileRepository()

    let delegate = MockUpdateProfileScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let viewModel = UpdateProfileViewModel(repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed saveIconName")
        let expectation1 = self.expectation(description: "Diplayed user")

        viewModel.saveIconName = { name in
            XCTAssertEqual(name, "save_button".localized)
            expectation0.fulfill()
        }
        viewModel.userDisplayed = { user in
            XCTAssertEqual(user[0], self.userItem)
            expectation1.fulfill()
        }

        viewModel.start()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_DidSelectSave_Then_DismissViewController() {

        let viewModel = UpdateProfileViewModel(repository: repository, delegate: delegate)

        viewModel.start()
        viewModel.saveNewUserInformations(with: ["name",
                                                 "surname",
                                                 "city",
                                                 "country",
                                                 "street",
                                                 "streetnumber",
                                                 "postaleCode",
                                                 "birth"])
        XCTAssertEqual(delegate.didLeaveTheView, true)

    }

}
