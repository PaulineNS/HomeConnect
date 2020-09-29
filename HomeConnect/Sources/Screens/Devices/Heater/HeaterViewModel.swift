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

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: HeaterRepositoryType,
         delegate: DevicesScreensDelegate?) {
        self.device = device
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var heaterDisplayed: ((DeviceItem) -> Void)?
    var heaterImage: ((String) -> Void)?
    var heaterName: ((String) -> Void)?
    var heaterProductType: ((String) -> Void)?
    var heaterMode: ((String) -> Void)?
    var heaterTemperature: ((String) -> Void)?
    var heaterDeleteIconName: ((String) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        heaterImage?("heater")
        heaterName?("\(device.deviceName)")
        heaterDeleteIconName?("dustbin")
        defineModeAndTemperature(for: device)
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
        temperature += 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didPressMinusButton() {
        guard temperature > 7.0 else {
            delegate?.devicesScreensShouldDisplayAlert(for: .minimumTemperatureReached)
            return
        }
        temperature -= 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didChangeModeSwitchValue(withOnvalue: Bool) {
        withOnvalue ? heaterTemperature?("\(temperature) C°") : heaterTemperature?("0 C°")
    }

    func defineModeAndTemperature(for device: DeviceItem) {
        switch device.productType {
        case .heater(let mode, let temperature):
            heaterMode?(mode)
            self.temperature = Double(temperature) ?? 1.1
            guard mode == "ON" else {
                heaterTemperature?("0 C°")
                return
            }
            heaterTemperature?("\(temperature) C°")
        default:
            return
        }
    }
}
