//
//  FiltersRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import Foundation

protocol FiltersRepositoryType: class {
    func searchDevice(productType: String,
                      mode: String?,
                      settings: String,
                      settingsValue: String,
                      completion: @escaping ([DeviceItem]) -> Void)
}

final class FiltersRepository: FiltersRepositoryType {

    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine

    // MARK: - Init

    init(dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }

    // MARK: - FiltersRepositoryType

    func searchDevice(productType: String,
                      mode: String? = nil,
                      settings: String,
                      settingsValue: String,
                      completion: @escaping ([DeviceItem]) -> Void) {
        let devices = dataBaseEngine.fetchDevicesWithFilters(productType: productType,
                                                             mode: mode,
                                                             settings: settings,
                                                             settingsValue: settingsValue)
        let deviceItem = devices.compactMap {
            DeviceItem(device: $0)
        }
        completion(deviceItem)
    }

}
