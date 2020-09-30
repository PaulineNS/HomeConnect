//
//  FiltersViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class FiltersViewModel {

    // MARK: - Private properties

    private let repository: FiltersRepositoryType
    private var deviceItem: [DeviceItem] = [] {
        didSet {
            print("")
        }
    }

    // MARK: - Initializer

    init(repository: FiltersRepositoryType) {
        self.repository = repository
    }

    // MARK: - Outputs

    var deviceDisplayed: ((UserItem) -> Void)?

    func searchDeviceWithFilters() {
        repository.searchDevice { devices in
            self.deviceItem = devices
        }
    }
}
