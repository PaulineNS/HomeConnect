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
    private weak var delegate: DevicesScreensDelegate?
    private var devicePosition = ""

    // MARK: - Initializer

    init(device: DeviceItem,
         repository: RollerShutterRepositoryType,
         delegate: DevicesScreensDelegate?) {
        self.device = device
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var rollerName: ((String) -> Void)?
    var rollerPosition: ((String) -> Void)?
    var rollerDeleteIconName: ((String) -> Void)?
    var rollerSaveButtonTilte: ((String) -> Void)?
    var rollerPositionMaxImageName: ((String) -> Void)?
    var rollerPositionMinImageName: ((String) -> Void)?

    // MARK: - Input

    func start() {
        rollerName?("\(device.deviceName)")
        rollerDeleteIconName?("dustbin")
        rollerSaveButtonTilte?("save_button".localized)
        rollerPositionMaxImageName?("open")
        rollerPositionMinImageName?("close")
        definePostion(for: device)
    }

    func didPressDeleteIconButton() {
        delegate?.devicesScreensShouldDisplayMultiChoicesAlert(for: .deleteDevice) { [weak self] response in
            if response, let deviceId = self?.device.idNumber {
                self?.repository.deleteDevice(with: deviceId)
                self?.delegate?.devicesScreenDidSelectDeleteButton()
            }
        }
    }

    func didChangeRollerPosition(with value: Int) {
        devicePosition = "\(value)"
        rollerPosition?(devicePosition)
    }

    func saveNewDeviceSettings() {
        repository.updateDevice(with: device.idNumber,
                                position: devicePosition)
        self.delegate?.devicesScreenDidSelectSaveButton()
    }

    // MARK: - Private Methods

    private func definePostion(for device: DeviceItem) {
        switch device.productType {
        case .rollerShutter(let position):
            devicePosition = position
            rollerPosition?(devicePosition)
        default:
            return
        }
    }

}
