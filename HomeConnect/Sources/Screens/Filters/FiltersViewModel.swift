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
    private weak var delegate: FiltersScreenDelegate?
    private var deviceItem: [DeviceItem] = [] {
        didSet {
        }
    }

    // MARK: - Initializer

    init(repository: FiltersRepositoryType,
         delegate: FiltersScreenDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var deviceDisplayed: ((UserItem) -> Void)?
    var searchIconName: ((String) -> Void)?
    var closeIconName: ((String) -> Void)?

    func viewDidLoad() {
        searchIconName?("filter_search_title".localized)
        closeIconName?("crossClose")
    }

    func searchDeviceWithFilters(productType: String,
                                 mode: String,
                                 settings: String,
                                 settingsValue: String) {
        repository.searchDevice(productType: productType,
                                mode: mode,
                                settings: settings,
                                settingsValue: settingsValue) { devices in
            self.deviceItem = devices
            guard devices.count != 0 else {
                self.delegate?.filtersScreenShouldDisplayAlert(for: .filtersError)
                return }
            self.delegate?.filtersScreenDidSelectSearchButton(device: self.deviceItem)
        }
    }

    func didSelectCrossButton() {
        delegate?.filtersScreenDidSelectCloseButton()
    }
}
