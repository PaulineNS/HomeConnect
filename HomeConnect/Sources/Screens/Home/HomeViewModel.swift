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

    init(repository: HomeRepositoryType,
         delegate: HomeScreenDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var homeTitle: ((String) -> Void)?
    var devicesDisplayed: (([DeviceItem]) -> Void)?

    func viewWillAppear() {
        getAllDevices()
    }

    func viewDidLoad() {
        homeTitle?("Mes Objects connectés")
    }

    func didSelectDevice(device: DeviceItem) {
        delegate?.homeScreenDidSelectDevice(device: device)
    }

    private func getAllDevices() {
        repository.getAllDevices(callback: { [weak self] response in
            DispatchQueue.main.async {
                self?.devices = response
            }
        }, failure: { [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
            }
        })
    }

}
