//
//  LightViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class LightViewModel {

    // MARK: - Private Properties

    private var device: DeviceItem
    private var repository: LightRepositoryType

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: LightRepositoryType) {
        self.device = device
        self.repository = repository
    }

    // MARK: - Output

    var lightDisplayed: ((DeviceItem) -> Void)?
    var lightImage: ((String) -> Void)?
    var lightName: ((String) -> Void)?
    var lightProductType: ((String) -> Void)?
    var lightMode: ((String) -> Void)?
    var lightIntensity: ((String) -> Void)?
    var navBarTitle: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        lightImage?("light")
        lightName?("\(device.deviceName)")

    }

}
