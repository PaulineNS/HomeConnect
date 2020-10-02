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
            //TODO
            print("")
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
        searchIconName?("Chercher")
        closeIconName?("crossClose")
    }

    func searchDeviceWithFilters() {
        repository.searchDevice { devices in
            self.deviceItem = devices
        }
    }

    func didSelectCrossButton() {
        delegate?.filtersScreenDidSelectCloseButton()
    }
}
