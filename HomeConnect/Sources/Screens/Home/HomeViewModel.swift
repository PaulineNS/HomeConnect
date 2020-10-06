//
//  HomeViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class HomeViewModel {

    // MARK: - Private properties

    private let repository: HomeRepositoryType
    private weak var delegate: HomeScreenDelegate?
    private var fromFilter = false
    private var deviceItems: [DeviceItem] = [] {
        didSet {
            guard !deviceItems.isEmpty else {
                delegate?.homeScreenShouldDisplayAlert(for: .noDevicesError)
                return
            }
            items?(deviceItems)
        }
    }

    private var unFilteredItems: [DeviceItem] = []

    // MARK: - Initializer

    init(repository: HomeRepositoryType,
         delegate: HomeScreenDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var homeTitle: ((String) -> Void)?
    var items: (([DeviceItem]) -> Void)?
    var profileIconName: ((String) -> Void)?
    var filterIconName: ((String) -> Void)?

    // MARK: - Life cycle

    func start() {
        homeTitle?("home_title".localized)
        profileIconName?("profile")
        if fromFilter {
            fromFilter = false
            filterIconName?("réinintialiser")
        } else {
            getAllDevices()
            filterIconName?("filter_title".localized)
        }
    }

    // MARK: - Inputs

    func didSelectDevice(device: DeviceItem) {
        delegate?.homeScreenDidSelectDevice(device: device)
    }

    func didSelectProfileButton() {
        delegate?.homeScreenDidSelectProfile()
    }

    func didSelectFilterButton() {
        delegate?.homeScreenDidSelectFilter()
    }

    func getFilteredItems(deviceItems: [DeviceItem]) {
        fromFilter = true
        self.deviceItems = deviceItems
    }

    func checkingFilterIconValue(with value: String) {
        guard value == "filter_title".localized else {
            resetFilters()
            return }
        didSelectFilterButton()
    }

    func resetFilters() {
        self.deviceItems = unFilteredItems
        filterIconName?("filter_title".localized)
    }

    // MARK: - Private Methods

    private func getAllDevices() {
        repository.getDevices { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(deviceItems):
                    self?.deviceItems = deviceItems
                    self?.unFilteredItems = deviceItems
                case .failure:
                    self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
                }
            }
        }
    }
}
