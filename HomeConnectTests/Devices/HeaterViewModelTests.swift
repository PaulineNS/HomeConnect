//
//  HeaterViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Tests

class HeaterViewModelTests: XCTestCase {

    let repository = MockHeaterRepository()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "Heater"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed heaterName")
        let expectation1 = self.expectation(description: "Diplayed heaterMode")
        let expectation2 = self.expectation(description: "Diplayed heaterTemperature")
        let expectation3 = self.expectation(description: "Diplayed heaterDeleteIconName")

        viewModel.heaterName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        viewModel.heaterMode = { mode in
            XCTAssertEqual(mode.rawValue, "ON")
            expectation1.fulfill()
        }
        viewModel.heaterTemperature = { temperature in
            XCTAssertEqual(temperature, "10 C°")
            expectation2.fulfill()
        }
        viewModel.heaterDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation3.fulfill()
        }

        viewModel.start()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_HeatertModeChange_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "Heater"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed heaterName")
        let expectation1 = self.expectation(description: "Diplayed heaterMode")
        let expectation2 = self.expectation(description: "Diplayed heaterTemperature")
        let expectation3 = self.expectation(description: "Diplayed heaterDeleteIconName")

        viewModel.heaterName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        var counter1 = 0
        viewModel.heaterMode = { mode in
            if counter1 == 1 {
                XCTAssertEqual(mode.rawValue, "OFF")
                expectation1.fulfill()
            }
            counter1 += 1
        }
        var counter2 = 0
        viewModel.heaterTemperature = { temperature in
            if counter2 == 1 {
                XCTAssertEqual(temperature, "0.0 C°")
                expectation2.fulfill()
            }
            counter2 += 1
        }
        viewModel.heaterDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation3.fulfill()
        }

        viewModel.start()
        viewModel.didChangeModeSwitchValue(withOnvalue: false)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_PlusButtonPressed_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "Heater"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed heaterName")
        let expectation1 = self.expectation(description: "Diplayed heaterMode")
        let expectation2 = self.expectation(description: "Diplayed heaterTemperature")
        let expectation3 = self.expectation(description: "Diplayed heaterDeleteIconName")

        viewModel.heaterName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        viewModel.heaterMode = { mode in
            XCTAssertEqual(mode.rawValue, "ON")
            expectation1.fulfill()
        }
        var counter = 0
        viewModel.heaterTemperature = { temperature in
            if counter == 1 {
                XCTAssertEqual(temperature, "10.5 C°")
                expectation2.fulfill()
            }
            counter += 1
        }
        viewModel.heaterDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation3.fulfill()
        }

        viewModel.start()
        viewModel.didPressPlusButton()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_MinusButtonPressed_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "Heater"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed heaterName")
        let expectation1 = self.expectation(description: "Diplayed heaterMode")
        let expectation2 = self.expectation(description: "Diplayed heaterTemperature")
        let expectation3 = self.expectation(description: "Diplayed heaterDeleteIconName")

        viewModel.heaterName = { name in
            XCTAssertEqual(name, deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        viewModel.heaterMode = { mode in
            XCTAssertEqual(mode.rawValue, "ON")
            expectation1.fulfill()
        }
        var counter = 0
        viewModel.heaterTemperature = { temperature in
            if counter == 1 {
                XCTAssertEqual(temperature, "9.5 C°")
                expectation2.fulfill()
            }
            counter += 1
        }
        viewModel.heaterDeleteIconName = { name in
            XCTAssertEqual(name, "dustbin")
            expectation3.fulfill()
        }

        viewModel.start()
        viewModel.didPressMinusButton()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didPressDeleteIconButton_Then_AlertISDisplayed() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.didPressDeleteIconButton()

        XCTAssertEqual(delegate.alert, .deleteDevice)

    }

    func test_Given_ViewModel_When_didPressSave_Then_TheViewIdDissmiss() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = HeaterViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.saveNewDeviceSettings()

        XCTAssertEqual(delegate.didLeaveTheViewAfterSave, true)

    }

}
