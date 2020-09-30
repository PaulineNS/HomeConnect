//
//  FiltersRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import Foundation

protocol FiltersRepositoryType: class {
    func searchDevice(completion: @escaping ([DeviceItem]) -> Void)
}

final class FiltersRepository: FiltersRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - FiltersRepositoryType

    func searchDevice(completion: @escaping ([DeviceItem]) -> Void) {
        let devices = dataBaseManager.fetchDevicesWithFilters()
        let deviceItem = devices.compactMap {
            DeviceItem(device: $0)
        }
        completion(deviceItem)
    }

}

private extension DeviceItem {
    init?(device: DeviceAttributes) {
        guard
            let deviceId = device.deviceId,
            let name = device.name,
            let type = ProductType(device: device)
            else {
            return nil
        }

        self.idNumber = "\(deviceId)"
        self.deviceName = name
        self.productType = type
    }
}
