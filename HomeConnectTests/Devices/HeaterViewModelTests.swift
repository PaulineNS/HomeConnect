//
//  HeaterViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

class HeaterViewModelTests: XCTestCase {

    let repository = MockHeaterRepository()
    let delegate = MockDevicesScreenDelegate()

    func test_Given_ViewModel_When_viewWillAppear_Then_ReactiveVariableAreDisplayed() {

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
            XCTAssertEqual(mode, "ON")
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

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
