//
//  HomeRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

enum DependanceType {
    case network
    case persistence
}

protocol HomeRepositoryType: class {
    func getUserDevices(success: @escaping ([DeviceItem], UserItem) -> Void,
                        failure: @escaping (() -> Void),
                        completion: @escaping ([DeviceItem]) -> Void)
}

final class HomeRepository: HomeRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClientType
    private var dependanceType: DependanceType
    private let dataBaseEngine: DataBaseEngine
    private let checker: UserDefaultChecker

    private let token = RequestCancellationToken()

    // MARK: - Init

    init(
        networkClient: HTTPClientType,
        dependanceType: DependanceType,
        dataBaseEngine: DataBaseEngine,
        checker: UserDefaultChecker
    ) {
        self.networkClient = networkClient
        self.dependanceType = dependanceType
        self.dataBaseEngine = dataBaseEngine
        self.checker = checker
    }

    // MARK: - HomeRepositoryType

    func getUserDevices( success: @escaping ([DeviceItem], UserItem) -> Void,
                         failure: @escaping (() -> Void),
                         completion: @escaping ([DeviceItem]) -> Void) {
        if checker.hasAlreadyBeenLaunched() {
            dependanceType = .persistence
        } else {
            dependanceType = .network
        }
        switch dependanceType {
        case .network:
            executeNetworkRequest(success: success, failure: failure)
        case .persistence:
            fetchPersistenceDevices(completion: completion)
        }
    }

    private func fetchPersistenceDevices(completion: @escaping ([DeviceItem]) -> Void) {
        let devices = dataBaseEngine.devices
        let devicesItem = devices.compactMap {
            DeviceItem(device: $0)
        }
        completion(devicesItem)
    }

    // MARK: - Private Methods

    private func executeNetworkRequest(success: @escaping ([DeviceItem], UserItem) -> Void,
                                       failure: @escaping (() -> Void)) {
        guard let url = URL(string: "http://storage42.com/modulotest/data.json") else {
            return
        }
        networkClient.request(requestType: .GET,
                              url: url,
                              cancelledBy: token) { (result: Result<DeviceResponse, HTTPClientError>) in
            switch result {
            case .success(let response):
                let devices = response
                    .devices?
                    .compactMap { DeviceItem(device: $0) } ?? []
                guard let user = response.user else {
                    return
                }
                let userItem = UserItem(user: user)
                self.dataBaseEngine.createUserEntity(userItem: userItem)
                devices.forEach { deviceItem in
                    self.dataBaseEngine.createDeviceEntity(deviceItem: deviceItem)
                }
                success(devices, userItem)
            case .failure:
                failure()
            }
        }
    }
}
