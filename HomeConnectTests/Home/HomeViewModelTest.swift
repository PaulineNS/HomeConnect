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

    var alert: AlertType?
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

    let repository = MockHomeRepository()
    var delegate = MockHomeScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_WithNetwork_Then_ReactiveVariableAreDisplayed() {

        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

//        let expectation0 = self.expectation(description: "Diplayed filterIconName")
        let expectation1 = self.expectation(description: "Diplayed homeTitle")
        let expectation2 = self.expectation(description: "Diplayed profileIconName")

//        viewModel.filterIconName = { name in
//            XCTAssertEqual(name, "filter_title".localized)
//            expectation0.fulfill()
//        }
        viewModel.homeTitle = { title in
            XCTAssertEqual(title, "home_title".localized)
            expectation1.fulfill()
        }
        viewModel.profileIconName = { name in
            XCTAssertEqual(name, "profile")
            expectation2.fulfill()
        }

        viewModel.start()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_viewWillAppear_WithNetwork_Then_visibleDevicesAreDiplayed() {

        repository.deviceItem = (mockDeviceResponse?.devices!.map { DeviceItem(device: $0)! })!
        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

        let expectation = self.expectation(description: "Diplayed devicesDiplayes")

        viewModel.items = { devices in
            XCTAssertEqual(devices, self.repository.deviceItem)
            expectation.fulfill()
        }

        viewModel.start()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didSelectProfileButton_Then_PopViewController() {

        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

        viewModel.didSelectProfileButton()

        XCTAssertEqual(delegate.didShowProfileView, true)
    }

    func test_Given_ViewModel_When_didSelectFilterButton_Then_PopViewController() {

        let viewModel = HomeViewModel(repository: repository, delegate: delegate)

        viewModel.didSelectFilterButton()

        XCTAssertEqual(delegate.didShowFilterView, true)
    }

}
