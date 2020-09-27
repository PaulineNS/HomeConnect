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
    private let token: RequestCancellationToken
    private var dependanceType: DependanceType
    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init(networkClient: HTTPClientType,
         token: RequestCancellationToken,
         dependanceType: DependanceType,
         dataBaseManager: DataBaseManager) {
        self.networkClient = networkClient
        self.token = token
        self.dependanceType = dependanceType
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - HomeRepositoryType

    func getUserDevices(
        success: @escaping ([DeviceItem], UserItem) -> Void,
        failure: @escaping (() -> Void),
        completion: @escaping ([DeviceItem]) -> Void
    ) {
        switch dependanceType {
        case .network:
            executeNetworkRequest(success: success, failure: failure)
        case .persistence:
            fetchPersistenceDevices(completion: completion)
        }
    }

    private func fetchPersistenceDevices(completion: @escaping ([DeviceItem]) -> Void) {
        guard let user = dataBaseManager.users.first else { return }
        let device = dataBaseManager.fetchDevicesDependingUser(user: user)
        let deviceItem = device.compactMap {
            DeviceItem(deviceAttributes: $0)}
        completion(deviceItem)
    }

    private func executeNetworkRequest(
        success: @escaping ([DeviceItem], UserItem) -> Void,
        failure: @escaping (() -> Void)
    ) {
        guard let url = URL(string: "http://storage42.com/modulotest/data.json") else {
            return
        }
        networkClient.request(
            requestType: .GET,
            url: url,
            cancelledBy: token
        ) { (result: Result<DeviceResponse, HTTPClientError>) in
            switch result {
            case .success(let response):
                let devices = response
                    .devices?
                    .compactMap {
                        DeviceItem(device: $0, user: self.dataBaseManager.users.first ?? UserAttributes())} ?? []

                guard let user = response.user else {
                    return
                }
                let userItem = UserItem(user: user)
                self.dataBaseManager.createUserEntity(userItem: userItem)
                devices.forEach { deviceItem in
                    guard let userAttributes = self.dataBaseManager.users.first else { return }
                    self.dataBaseManager.createDeviceEntity(deviceItem: deviceItem,
                                                            user: userAttributes)
                }
                self.dependanceType = .persistence
                success(devices, userItem)
            case .failure:
                failure()
            }
        }
    }
}

private extension DeviceItem {
    init(device: DeviceResponse.Device, user: UserAttributes) {
        self.idNumber = String(device.id ?? 0)
        self.deviceName = device.deviceName
        self.intensity = String(device.intensity ?? 0)
        self.mode = device.mode
        self.productType = ProductType(rawValue: device.productType ?? "")
        self.position = String(device.position ?? 0)
        self.temperature = String(device.temperature ?? 0)
        self.user = user
    }
}

private extension DeviceItem {
    init(deviceAttributes: DeviceAttributes) {
        self.idNumber = deviceAttributes.deviceId
        self.deviceName = deviceAttributes.name
        self.intensity = deviceAttributes.intensity
        self.mode = deviceAttributes.mode
        self.productType = ProductType(rawValue: deviceAttributes.productType ?? "")
        self.position = deviceAttributes.position
        self.temperature = deviceAttributes.temperature
        self.user = deviceAttributes.owner ?? UserAttributes()
    }
}

private extension UserItem {
    init(user: DeviceResponse.User) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthDate = user.birthDate
        self.city = user.address?.city
        self.postalCode = user.address?.postalCode
        self.street = user.address?.street
        self.streetCode = user.address?.streetCode
        self.country = user.address?.country
    }
}
