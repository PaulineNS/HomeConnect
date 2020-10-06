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
    private var intensity = 10
    private var mode = "ON"

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: LightRepositoryType,
         delegate: DevicesScreensDelegate?) {
        self.device = device
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var lightName: ((String) -> Void)?
    var lightMode: ((String) -> Void)?
    var lightIntensity: ((String) -> Void)?
    var lightDeleteIconName: ((String) -> Void)?
    var lightOnSwitchName: ((String) -> Void)?
    var lightOffSwitchName: ((String) -> Void)?
    var lightSaveButtonTilte: ((String) -> Void)?
    var lightIntensityMaxImageName: ((String) -> Void)?
    var lightIntensityMinImageName: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        lightName?("\(device.deviceName)")
        lightDeleteIconName?("dustbin")
        lightOnSwitchName?("on_status".localized)
        lightOffSwitchName?("off_status".localized)
        lightSaveButtonTilte?("save_button".localized)
        lightIntensityMaxImageName?("lightOn")
        lightIntensityMinImageName?("lightOff")
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
            lightMode?("OFF")
            lightIntensity?("0")
            mode = "OFF"
            intensity = 0
            return
        }
        lightIntensity?("50")
        lightMode?("ON")
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
