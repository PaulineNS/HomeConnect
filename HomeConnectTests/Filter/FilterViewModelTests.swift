//
//  FilterViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 07/10/2020.
//

import XCTest
@ testable import HomeConnect

class MockFiltersScreenDelegate: FiltersScreenDelegate {
    var alert: AlertType?
    var didLeaveTheViewAfterDismiss = false
    var didLeaveTheViewAfterSearch = false

    func filtersScreenDidSelectCloseButton() {
        didLeaveTheViewAfterDismiss = true
    }

    func filtersScreenDidSelectSearchButton(device: [DeviceItem]) {
        didLeaveTheViewAfterSearch = true
    }

    func filtersScreenShouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }

}

class FiltersViewModelTests: XCTestCase {

    let deviceItems: [DeviceItem] = [DeviceItem(device: DeviceMock())!]
    let repository = MockFilterRepository()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let delegate = MockFiltersScreenDelegate()

        let viewModel = FiltersViewModel(repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed Search Icon")
        let expectation1 = self.expectation(description: "Diplayed Close Icon")

        viewModel.searchIconName = { name in
            XCTAssertEqual(name, "filter_search_title".localized)
            expectation0.fulfill()
        }
        viewModel.closeIconName = { name in
            XCTAssertEqual(name, "crossClose")
            expectation1.fulfill()
        }
        viewModel.start()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didPressClose_Then_TheViewIsDissmiss() {

        let delegate = MockFiltersScreenDelegate()

        let viewModel = FiltersViewModel(repository: repository, delegate: delegate)

        viewModel.didSelectCrossButton()

        XCTAssertEqual(delegate.didLeaveTheViewAfterDismiss, true)
    }

    func test_Given_ViewModel_When_didPressSearchAndDeviceDoNotExist_Then_AlertDisplay() {

        let delegate = MockFiltersScreenDelegate()

        let deviceMock = DeviceMock()
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = FiltersViewModel(repository: repository, delegate: delegate)

        repository.dataBaseEngine.createDeviceEntity(deviceItem: deviceItems.first!)

        viewModel.searchDeviceWithFilters(productType: "RollerShutter",
                                          mode: "ON",
                                          settings: "intensity",
                                          settingsValue: "10")

        XCTAssertEqual(delegate.didLeaveTheViewAfterSearch, false)
        XCTAssertEqual(delegate.alert, .filtersError)
    }
}
