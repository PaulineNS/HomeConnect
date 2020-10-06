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
            devicesDisplayed?(deviceItems)
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
    var devicesDisplayed: (([DeviceItem]) -> Void)?
    var profileIconName: ((String) -> Void)?
    var filterIconName: ((String) -> Void)?

    // MARK: - Life cycle

    func viewWillAppear() {
        if fromFilter {
            fromFilter = false
            filterIconName?("réinintialiser")
        } else {
            getAllDevices()
            filterIconName?("filter_title".localized)
        }
    }

    func viewDidLoad() {
        homeTitle?("home_title".localized)
        profileIconName?("profile")
        filterIconName?("filter_title".localized)
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
        repository.getUserDevices(success: { [weak self] deviceResponse, _ in
            DispatchQueue.main.async {
                self?.deviceItems = deviceResponse
                self?.unFilteredItems = deviceResponse
            }
        }, failure: { [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
            }
        }, completion: { [weak self] persistence in
            DispatchQueue.main.async {
                self?.deviceItems = persistence
                self?.unFilteredItems = persistence
            }
        })
    }
}
