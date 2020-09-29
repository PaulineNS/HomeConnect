//
//  HeaterViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class HeaterViewModel {

    // MARK: - Private Properties

    private var device: DeviceItem
    private var repository: HeaterRepositoryType

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: HeaterRepositoryType) {
        self.device = device
        self.repository = repository
    }

    // MARK: - Output

    var heaterDisplayed: ((DeviceItem) -> Void)?
    var heaterImage: ((String) -> Void)?
    var heaterName: ((String) -> Void)?
    var heaterProductType: ((String) -> Void)?
    var heaterMode: ((String) -> Void)?
    var heaterTemperature: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        heaterImage?("heater")
        heaterName?("\(device.deviceName)")
    }

}
