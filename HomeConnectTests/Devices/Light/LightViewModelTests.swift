//
//  LightViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mocks

class MockDevicesScreenDelegate: DevicesScreensDelegate {
    var alert: AlertType?
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

// MARK: - Tests

class LightViewModelTests: XCTestCase {

    let deviceItems: [DeviceItem] = [DeviceItem(device: DeviceMock())!]

    let repository = MockLightRepository()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

        let delegate = MockDevicesScreenDelegate()

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
            XCTAssertEqual(mode.rawValue, "ON")
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

        viewModel.start()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_LightModeChange_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed lightName")
        let expectation2 = self.expectation(description: "Diplayed lighMode")
        let expectation3 = self.expectation(description: "Diplayed lighIntensity")
        let expectation4 = self.expectation(description: "Diplayed lighDeleteIconName")

        viewModel.lightName = { name in
            XCTAssertEqual(name, self.deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        var counter1 = 0
        viewModel.lightMode = { mode in
            if counter1 == 1 {
                XCTAssertEqual(mode.rawValue, "OFF")
                expectation2.fulfill()
            }
            counter1+=1
        }

        var counter2 = 0
        viewModel.lightIntensity = { intensity in
            if counter2 == 1 {
                XCTAssertEqual(intensity, "0")
                expectation3.fulfill()
            }
            counter2+=1
        }

        viewModel.lightDeleteIconName = { name in
                XCTAssertEqual(name, "dustbin")
                expectation4.fulfill()
        }

        viewModel.start()
        viewModel.didChangeModeSwitchValue(withOnvalue: false)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_IntensityChangeToZero_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed lightName")
        let expectation2 = self.expectation(description: "Diplayed lighMode")
        let expectation3 = self.expectation(description: "Diplayed lighIntensity")
        let expectation4 = self.expectation(description: "Diplayed lighDeleteIconName")

        viewModel.lightName = { name in
            XCTAssertEqual(name, self.deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        var counter1 = 0
        viewModel.lightMode = { mode in
            if counter1 == 1 {
                XCTAssertEqual(mode.rawValue, "OFF")
                expectation2.fulfill()
            }
            counter1+=1
        }

        var counter2 = 0
        viewModel.lightIntensity = { intensity in
            if counter2 == 1 {
                XCTAssertEqual(intensity, "0")
                expectation3.fulfill()
            }
            counter2+=1
        }

        viewModel.lightDeleteIconName = { name in
                XCTAssertEqual(name, "dustbin")
                expectation4.fulfill()
        }

        viewModel.start()
        viewModel.didChangeLightIntensity(with: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_IntensityChangeToTen_Then_ReactiveVariableChanged() {

        let delegate = MockDevicesScreenDelegate()

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        let expectation0 = self.expectation(description: "Diplayed lightName")
        let expectation2 = self.expectation(description: "Diplayed lighMode")
        let expectation3 = self.expectation(description: "Diplayed lighIntensity")
        let expectation4 = self.expectation(description: "Diplayed lighDeleteIconName")

        viewModel.lightName = { name in
            XCTAssertEqual(name, self.deviceItems.first?.deviceName)
            expectation0.fulfill()
        }
        var counter1 = 0
        viewModel.lightMode = { mode in
            if counter1 == 1 {
                XCTAssertEqual(mode.rawValue, "ON")
                expectation2.fulfill()
            }
            counter1+=1
        }

        var counter2 = 0
        viewModel.lightIntensity = { intensity in
            if counter2 == 1 {
                XCTAssertEqual(intensity, "10")
                expectation3.fulfill()
            }
            counter2+=1
        }

        viewModel.lightDeleteIconName = { name in
                XCTAssertEqual(name, "dustbin")
                expectation4.fulfill()
        }

        viewModel.start()
        viewModel.didChangeLightIntensity(with: 10)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didPressDeleteIconButton_Then_AlertISDisplayed() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.didPressDeleteIconButton()

        XCTAssertEqual(delegate.alert, .deleteDevice)

    }

    func test_Given_ViewModel_When_didPressSave_Then_TheViewIdDissmiss() {

        let delegate = MockDevicesScreenDelegate()

        var deviceMock = DeviceMock()
        deviceMock.productType = "RollerShutter"
        let deviceItems: [DeviceItem] = [DeviceItem(device: deviceMock)!]

        let viewModel = LightViewModel(device: deviceItems.first!, repository: repository, delegate: delegate)

        viewModel.saveNewDeviceSettings()

        XCTAssertEqual(delegate.didLeaveTheViewAfterSave, true)

    }

}
