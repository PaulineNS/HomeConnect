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
    private var intensity = 0
    private var mode = ""

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
                self?.repository.deleteDevice(with: deviceId)
                self?.delegate?.devicesScreenDidSelectDeleteButton()
            }
        }
    }

    func didChangeLightIntensity(with value: Int) {
        if value == 0 {
            lightMode?("OFF")
            mode = "OFF"
        } else {
            lightMode?("ON")
            mode = "ON"
        }
        lightIntensity?("\(value)")
        intensity = value
    }

    func didChangeModeSwitchValue(withOnvalue: Bool) {
        guard withOnvalue else {
            lightIntensity?("0")
            mode = "OFF"
            intensity = 0
            return
        }
        lightIntensity?("50")
        mode = "ON"
        intensity = 50
    }

    func saveNewDeviceSettings() {
        repository.updateDevice(with: device.idNumber,
                                mode: mode,
                                intensity: String(intensity))
        self.delegate?.devicesScreenDidSelectSaveButton()
    }

    func defineLightAndIntensity(for device: DeviceItem) {
        switch device.productType {
        case .light(let mode, let intensity):
            self.intensity = Int(intensity) ?? 0
            self.mode = mode
            if mode == "ON" && intensity != "0" {
                lightMode?("\(mode)")
                lightIntensity?("\(intensity)")
            } else {
                lightMode?("OFF")
                lightIntensity?("\(intensity)")
            }
        default:
            return
        }
    }
}
