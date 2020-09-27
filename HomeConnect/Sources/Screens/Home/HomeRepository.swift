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
    private let dependanceType: DependanceType
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
                        DeviceItem(device: $0)} ?? []

                guard let user = response.user else {
                    return
                }
                let userItem = UserItem(user: user)
                self.dataBaseManager.createUserEntity(userItem: userItem)

                devices.forEach { deviceItem in
                    guard let userAttributes = self.dataBaseManager.users.first else { return }
                    self.dataBaseManager.createDeviceEntity(deviceItem: deviceItem, user: userAttributes)
                }
                success(devices, userItem)
            case .failure:
                failure()
            }
        }
    }
}

private extension DeviceItem {
    init(device: DeviceResponse.Device) {
        self.idNumber = device.idNumber
        self.deviceName = device.deviceName
        self.intensity = device.intensity
        self.mode = device.mode
        self.productType = ProductType(rawValue: device.productType ?? "")
        self.position = device.position
        self.temperature = device.temperature
    }
}

private extension DeviceItem {
    init(deviceAttributes: DeviceAttributes) {
        self.idNumber = Int(deviceAttributes.deviceId ?? "")
        self.deviceName = deviceAttributes.name
        self.intensity = Int(deviceAttributes.intensity ?? "")
        self.mode = deviceAttributes.mode
        self.productType = ProductType(rawValue: deviceAttributes.productType ?? "")
        self.position = Int(deviceAttributes.position ?? "")
        self.temperature = Int(deviceAttributes.temperature ?? "")
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
