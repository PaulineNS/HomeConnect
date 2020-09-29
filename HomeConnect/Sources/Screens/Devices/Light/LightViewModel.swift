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
    private weak var delegate: DevicesScreensDelegate?

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: LightRepositoryType,
         delegate: DevicesScreensDelegate?) {
        self.device = device
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var lightDisplayed: ((DeviceItem) -> Void)?
    var lightImage: ((String) -> Void)?
    var lightName: ((String) -> Void)?
    var lightProductType: ((String) -> Void)?
    var lightMode: ((String) -> Void)?
    var lightIntensity: ((String) -> Void)?
    var lightDeleteIconName: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        lightImage?("light")
        lightName?("\(device.deviceName)")
        lightDeleteIconName?("dustbin")
        defineLightAndIntensity(for: device)
    }
    
    func didPressDeleteIconButton() {
        delegate?.devicesScreensShouldDisplayMultiChoicesAlert(for: .deleteDevice) { [weak self] response in
            if response, let deviceId = self?.device.idNumber {
                self?.repository.deleteItem(with: deviceId)
                self?.delegate?.devicesScreenDidSelectDeleteButton()
            }
        }
    }

    func defineLightAndIntensity(for device: DeviceItem) {
        switch device.productType {
        case .light(let mode, let intensity):
            lightMode?("\(mode)")
            lightIntensity?("\(intensity)")
        default:
            return
        }
    }

}
