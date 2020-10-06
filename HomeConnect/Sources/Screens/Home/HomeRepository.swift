//
//  HomeRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

protocol HomeRepositoryType: class {
    func getDevices(callback: @escaping (Result<[DeviceItem], Error>) -> Void)
}

final class HomeRepository: HomeRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClientType
    private let dataBaseEngine: DataBaseEngine
    private let checker: UserDefaultCheckerType

    private let token = RequestCancellationToken()

    // MARK: - Init

    init(
        networkClient: HTTPClientType,
        dataBaseEngine: DataBaseEngine,
        checker: UserDefaultCheckerType
    ) {
        self.networkClient = networkClient
        self.dataBaseEngine = dataBaseEngine
        self.checker = checker
    }

    // MARK: - HomeRepositoryType

    func getDevices(callback: @escaping (Result<[DeviceItem], Error>) -> Void) {
        if checker.hasAlreadyBeenLaunched() {
            fetchPersistenceDevices(callback: callback)
        } else {
            executeNetworkRequest(callback: callback)
        }
    }

    private func fetchPersistenceDevices(callback: @escaping (Result<[DeviceItem], Error>) -> Void) {
        let devices = dataBaseEngine.devices
        let deviceItems = devices.compactMap {
            DeviceItem(device: $0)
        }
        callback(.success(deviceItems))
    }

    // MARK: - Private Methods

    private func executeNetworkRequest(callback: @escaping (Result<[DeviceItem], Error>) -> Void) {
        guard let url = URL(string: "http://storage42.com/modulotest/data.json") else {
            return
        }
        networkClient.request(requestType: .GET,
                              url: url,
                              cancelledBy: token) { (result: Result<DeviceResponse, HTTPClientError>) in
            switch result {
            case .success(let response):
                let deviceItems = response
                    .devices?
                    .compactMap { DeviceItem(device: $0) } ?? []
                callback(.success(deviceItems))
                self.save(user: response.user)
                self.save(devices: deviceItems)
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }

    private func save(user: DeviceResponse.User?) {
        guard let user = user else { return }
        let userItem = UserItem(user: user)
        dataBaseEngine.createUserEntity(userItem: userItem)
    }

    private func save(devices: [DeviceItem]) {
        devices.forEach { self.dataBaseEngine.createDeviceEntity(deviceItem: $0) }
    }
}
