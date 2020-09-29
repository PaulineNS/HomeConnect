//
//  RollerShutterViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class RollerShutterViewModel {

    // MARK: - Private Properties

    private var device: DeviceItem
    private var repository: RollerShutterRepositoryType

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: RollerShutterRepositoryType) {
        self.device = device
        self.repository = repository
    }

    // MARK: - Output

    var rollerDisplayed: ((DeviceItem) -> Void)?
    var rollerImage: ((String) -> Void)?
    var rollerName: ((String) -> Void)?
    var rollerProductType: ((String) -> Void)?
    var rollerPosition: ((String) -> Void)?
    var rollerDeleteIconName: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        rollerImage?("rollerShutter")
        rollerName?("\(device.deviceName)")
        rollerDeleteIconName?("dustbin")
        definePostion(for: device)
    }

    func definePostion(for device: DeviceItem) {
        switch device.productType {
        case .rollerShutter(let position):
            rollerPosition?("\(position)")
        default:
            return
        }
    }

}
