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
    private var devices: [DeviceItem] = [] {
        didSet {
            guard !devices.isEmpty else {
                delegate?.homeScreenShouldDisplayAlert(for: .noDevicesError)
                return
            }
            devicesDisplayed?(devices)
        }
    }

    // MARK: - Initializer

    // TODO
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
        getAllDevices()
    }

    func viewDidLoad() {
        homeTitle?("Mes Objets")
        profileIconName?("profile")
        filterIconName?("Filtrer")
    }

    // MARK: - Methods

    func didSelectDevice(device: DeviceItem) {
        delegate?.homeScreenDidSelectDevice(device: device)
    }

    func didSelectProfileButton() {
        delegate?.homeScreenDidSelectProfile()
    }

    func didSelectFilterButton() {
        delegate?.homeScreenDidSelectFilter()
    }

    private func getAllDevices() {
        repository.getUserDevices(success: { [weak self] deviceResponse, _ in
            DispatchQueue.main.async {
                self?.devices = deviceResponse
            }
        }, failure: { [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
            }
        }, completion: { [weak self] persistence in
            DispatchQueue.main.async {
                self?.devices = persistence
            }
        })
    }
}
