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

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init(dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - FiltersRepositoryType

    func searchDevice(completion: @escaping ([DeviceItem]) -> Void) {
        let devices = dataBaseEngine.fetchDevicesWithFilters()
        let deviceItem = devices.compactMap {
            DeviceItem(device: $0)
        }
        completion(deviceItem)
    }

}
