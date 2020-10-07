//
//  LightViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

enum LightMode: String {
    case on = "ON"
    case off = "OFF"
}

final class LightViewModel {

    // MARK: - Private Properties

    private var device: DeviceItem
    private var repository: LightRepositoryType
    private weak var delegate: DevicesScreensDelegate?
    private var intensity = 10
    private var mode: LightMode? = .on {
        didSet {
            guard let mode = mode else { return }
            lightMode?(mode)
        }
    }

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
    var lightMode: ((LightMode) -> Void)?
    var lightIntensity: ((String) -> Void)?
    var lightDeleteIconName: ((String) -> Void)?
    var lightOnSwitchName: ((String) -> Void)?
    var lightOffSwitchName: ((String) -> Void)?
    var lightSaveButtonTilte: ((String) -> Void)?
    var lightIntensityMaxImageName: ((String) -> Void)?
    var lightIntensityMinImageName: ((String) -> Void)?

    // MARK: - Inputs

    func start() {
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
            mode = .off
        } else {
            mode = .on
        }
        lightIntensity?("\(value)")
        intensity = value
    }

    func didChangeModeSwitchValue(withOnvalue: Bool) {
        guard withOnvalue else {
            mode = .off
            lightIntensity?("0")
            intensity = 0
            return
        }
        lightIntensity?("50")
        mode = .on
        intensity = 50
    }

    func saveNewDeviceSettings() {
        guard let mode = mode?.rawValue else { return }
        repository.updateDevice(with: device.idNumber,
                                mode: mode,
                                intensity: String(intensity))
        self.delegate?.devicesScreenDidSelectSaveButton()
    }

    func defineLightAndIntensity(for device: DeviceItem) {
        switch device.productType {
        case .light(let mode, let intensity):
            self.intensity = Int(intensity) ?? 0
            if mode == "ON" && intensity != "0" {
                self.mode = .on
                lightIntensity?("\(intensity)")
            } else {
                self.mode = .off
                lightIntensity?("\(intensity)")
            }
        default:
            return
        }
    }
}
