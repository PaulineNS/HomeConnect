//
//  RollerShutterViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Tests

class RollerShutterViewModelTests: XCTestCase {

    let repository = MockRollerShutterRepository()
    let delegate = MockDevicesScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = RollerShutterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed rollerName")
        let expectation1 = self.expectation(description: "Diplayed rollerPosition")
        let expectation2 = self.expectation(description: "Diplayed rollerDeleteIconName")

        viewModel.rollerName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        viewModel.rollerPosition = { position in
            XCTAssertEqual(position, "10")
            expectation1.fulfill()
        }
        viewModel.rollerDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation2.fulfill()
        }

        viewModel.start()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_RollerPositionChange_Then_ReactiveVariableChanged() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = RollerShutterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed rollerName")
        let expectation1 = self.expectation(description: "Diplayed rollerPosition")
        let expectation2 = self.expectation(description: "Diplayed rollerDeleteIconName")

        viewModel.rollerName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        var counter = 0
        viewModel.rollerPosition = { position in
            if counter == 1 {
            XCTAssertEqual(position, "100")
            expectation1.fulfill()
            }
            counter += 1
        }
        viewModel.rollerDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation2.fulfill()
        }
        viewModel.start()
        viewModel.didChangeRollerPosition(with: 100)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didPressDeleteIconButton_Then_AlertISDisplayed() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = RollerShutterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.didPressDeleteIconButton()

        XCTAssertEqual(delegate.alert, .deleteDevice)

    }

    func test_Given_ViewModel_When_didPressSave_Then_TheViewIdDissmiss() {

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = RollerShutterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.saveNewDeviceSettings()

        XCTAssertEqual(delegate.didLeaveTheViewAfterSave, true)

    }
}
