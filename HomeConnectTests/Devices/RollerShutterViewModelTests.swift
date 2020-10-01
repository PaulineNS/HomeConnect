//
//  RollerShutterViewModelTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

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

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
