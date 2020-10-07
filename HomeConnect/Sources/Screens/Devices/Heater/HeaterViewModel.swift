//
//  HeaterViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

enum HeaterMode: String {
    case on = "ON"
    case off = "OFF"
}

final class HeaterViewModel {

    // MARK: - Private Properties

    private var device: DeviceItem
    private var repository: HeaterRepositoryType
    private weak var delegate: DevicesScreensDelegate?
    private var temperature = 0.0
    private var mode: HeaterMode? = .off {
        didSet {
            guard let mode = mode else { return }
            heaterMode?(mode)
        }
    }

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
    var heaterMode: ((HeaterMode) -> Void)?
    var heaterTemperature: ((String) -> Void)?
    var heaterDeleteIconName: ((String) -> Void)?
    var heaterSwitchOnText: ((String) -> Void)?
    var heaterSwitchOffText: ((String) -> Void)?
    var heaterSaveButtonTitle: ((String) -> Void)?
    var heaterPlusButtonImageName: ((String) -> Void)?
    var heaterMinButtonImageName: ((String) -> Void)?

    // MARK: - Input

    func start() {
        heaterName?("\(device.deviceName)")
        heaterDeleteIconName?("dustbin")
        defineModeAndTemperature(for: device)
        heaterSwitchOnText?("on_status".localized)
        heaterSwitchOffText?("off_status".localized)
        heaterSaveButtonTitle?("save_button".localized)
        heaterPlusButtonImageName?("plusIcon")
        heaterMinButtonImageName?("minusIcon")
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
        if mode == .off {
            mode = .on
        }
        temperature += 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didPressMinusButton() {
        guard temperature > 7.0 else {
            delegate?.devicesScreensShouldDisplayAlert(for: .minimumTemperatureReached)
            return
        }
        if mode == .off {
            mode = .on
        }
        temperature -= 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didChangeModeSwitchValue(withOnvalue: Bool) {
        guard withOnvalue else {
            heaterTemperature?("0.0 C°")
            temperature = 0.0
            mode = .off
            return
        }
        temperature = 14.0
        heaterTemperature?("\(temperature) C°")
        mode = .on
    }

    func saveNewDeviceSettings() {
        guard let mode = mode?.rawValue else { return }
        repository.updateDevice(with: device.idNumber,
                                mode: mode,
                                temperature: String(temperature))
        self.delegate?.devicesScreenDidSelectSaveButton()
    }

    // MARK: - Private Methods

    func defineModeAndTemperature(for device: DeviceItem) {
        switch device.productType {
        case .heater(let mode, let temperature):
            self.temperature = Double(temperature) ?? 1.1
            guard mode == "ON" else {
                self.mode = .off
                heaterTemperature?("0 C°")
                self.temperature = 0.0
                return
            }
            self.mode = .on
            heaterTemperature?("\(temperature) C°")
        default:
            return
        }
    }
}
