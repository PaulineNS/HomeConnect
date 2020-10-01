//
//  HomeViewModelTest.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mock

class MockHomeScreenDelegate: HomeScreenDelegate {

    var alert: AlertType? = nil
    var didShowFilterView = false
    var didShowProfileView = false

    var deviceItem = DeviceItem(device: DeviceMock())

    func homeScreenDidSelectDevice(device: DeviceItem) {
        deviceItem = device
    }

    func homeScreenDidSelectProfile() {
        didShowProfileView = true
    }

    func homeScreenDidSelectFilter() {
        didShowFilterView = true
    }

    func homeScreenShouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }
}

class HomeViewModelTests: XCTestCase {

    let deviceItem: [DeviceItem] = [DeviceItem(device: DeviceMock())!]
    let userItem = UserItem(firstName: "Pauline",
                            lastName: "Nomballais",
                            birthDate: 100591,
                            city: "Paris",
                            postalCode: 75001,
                            street: "Paris",
                            streetCode: "44",
                            country: "France")

    let repository = MockHomeRepository()
    let delegate = MockHomeScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_WithNetwork_Then_ReactiveVariableAreDisplayed() {

        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed filterIconName")
        let expectation1 = self.expectation(description: "Diplayed homeTitle")
        let expectation2 = self.expectation(description: "Diplayed profileIconName")

        viewModel.filterIconName = { name in
            XCTAssertEqual(name, "Filtrer")
            expectation0.fulfill()
        }
        viewModel.homeTitle = { title in
            XCTAssertEqual(title, "Mes Objets")
            expectation1.fulfill()
        }
        viewModel.profileIconName = { name in
            XCTAssertEqual(name, "profile")
            expectation2.fulfill()
        }

        viewModel.viewDidLoad()
        viewModel.viewWillAppear()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_viewWillAppear_WithNetwork_Then_visibleDevicesAreDiplayed() {

        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

        let expectation = self.expectation(description: "Diplayed devicesDiplayes")

        viewModel.devicesDisplayed = { devices in
            XCTAssertEqual(devices, self.repository.deviceItem)
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        viewModel.viewWillAppear()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

}