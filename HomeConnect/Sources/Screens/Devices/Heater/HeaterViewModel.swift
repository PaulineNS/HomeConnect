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
    private weak var delegate: DevicesScreensDelegate?
    private var temperature = 0.0
    private var mode = ""

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: HeaterRepositoryType,
         delegate: DevicesScreensDelegate?) {
        self.device = device
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var heaterName: ((String) -> Void)?
    var heaterMode: ((String) -> Void)?
    var heaterTemperature: ((String) -> Void)?
    var heaterDeleteIconName: ((String) -> Void)?
    var heaterSwitchOnText: ((String) -> Void)?
    var heaterSwitchOffText: ((String) -> Void)?
    var heaterSaveButtonTitle: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        heaterName?("\(device.deviceName)")
        heaterDeleteIconName?("dustbin")
        defineModeAndTemperature(for: device)
        heaterSwitchOnText?("On")
        heaterSwitchOffText?("Off")
        heaterSaveButtonTitle?("Enregistrer")
    }

    func didPressDeleteIconButton() {
        delegate?.devicesScreensShouldDisplayMultiChoicesAlert(for: .deleteDevice) { [weak self] response in
            if response, let deviceId = self?.device.idNumber {
                self?.repository.deleteItem(with: deviceId)
                self?.delegate?.devicesScreenDidSelectDeleteButton()
            }
        }
    }

    func didPressPlusButton() {
        guard temperature < 28.0 else {
            delegate?.devicesScreensShouldDisplayAlert(for: .maximumTemperatureReached)
            return
        }
        if temperature < 7.0 {
            temperature = 6.5
        }
        if mode == "OFF"{
            heaterMode?("ON")
            mode = "ON"
        }
        temperature += 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didPressMinusButton() {
        guard temperature > 7.0 else {
            delegate?.devicesScreensShouldDisplayAlert(for: .minimumTemperatureReached)
            return
        }
        if mode == "OFF"{
            heaterMode?("ON")
            mode = "ON"
        }
        temperature -= 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didChangeModeSwitchValue(withOnvalue: Bool) {
        guard withOnvalue else {
            heaterMode?("OFF")
            heaterTemperature?("0.0 C°")
            temperature = 0.0
            mode = "OFF"
            return
        }
        heaterMode?("ON")
        temperature = 14.0
        heaterTemperature?("\(temperature) C°")
        mode = "ON"
    }

    func saveNewDeviceSettings() {
        repository.updateDevice(with: device.idNumber,
                                mode: mode,
                                temperature: String(temperature))
        self.delegate?.devicesScreenDidSelectSaveButton()
    }

    // MARK: - Private Methods

    func defineModeAndTemperature(for device: DeviceItem) {
        switch device.productType {
        case .heater(let mode, let temperature):
            heaterMode?(mode)
            self.mode = mode
            self.temperature = Double(temperature) ?? 1.1
            guard mode == "ON" else {
                heaterTemperature?("0 C°")
                self.temperature = 0.0
                return
            }
            heaterTemperature?("\(temperature) C°")
        default:
            return
        }
    }
}
