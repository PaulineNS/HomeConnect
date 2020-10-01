//
//  LightViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mock

class MockDevicesScreenDelegate: DevicesScreensDelegate {
    var alert: AlertType? = nil
    var didLeaveTheViewAfterDismiss = false
    var didLeaveTheViewAfterSave = false

    func devicesScreensShouldDisplayAlert(for type: AlertType) {
        self.alert = type
    }

    func devicesScreenDidSelectDeleteButton() {
        didLeaveTheViewAfterDismiss = true
    }

    func devicesScreenDidSelectSaveButton() {
        didLeaveTheViewAfterSave = true
    }

    func devicesScreensShouldDisplayMultiChoicesAlert(for type: AlertType, completion: @escaping (Bool) -> Void) {
        self.alert = type

    }
}

class LightViewModelTests: XCTestCase {

    let deviceItems: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    let repository = MockLightRepository()

    let delegate = MockDevicesScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed lightName")
        let expectation2 = self.expectation(description: "Diplayed lighMode")
        let expectation3 = self.expectation(description: "Diplayed lighIntensity")
        let expectation4 = self.expectation(description: "Diplayed lighDeleteIconName")

        viewModel.lightName = { name in
            XCTAssertEqual(name, self.deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        viewModel.lightMode = { mode in
            XCTAssertEqual(mode, "ON")
            expectation2.fulfill()
        }
        viewModel.lightIntensity = { intensity in
            XCTAssertEqual(intensity, "10")
            expectation3.fulfill()
        }
        viewModel.lightDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation4.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
