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
    private let checker: UserDefaultChecker

    // MARK: - Init

    init(
        networkClient: HTTPClientType,
        token: RequestCancellationToken,
        dependanceType: DependanceType,
        dataBaseManager: DataBaseManager,
        checker: UserDefaultChecker
    ) {
        self.networkClient = networkClient
        self.token = token
        self.dependanceType = dependanceType
        self.dataBaseManager = dataBaseManager
        self.checker = checker
    }

    // MARK: - HomeRepositoryType

    func getUserDevices(
        success: @escaping ([DeviceItem], UserItem) -> Void,
        failure: @escaping (() -> Void),
        completion: @escaping ([DeviceItem]) -> Void
    ) {
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
        let devices = dataBaseManager.devices
        let devicesItem = devices.compactMap {
            DeviceItem(device: $0)
        }
        completion(devicesItem)
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
                                .compactMap { DeviceItem(device: $0) } ?? []

                            guard let user = response.user else {
                                return
                            }
                            let userItem = UserItem(user: user)
                            self.dataBaseManager.createUserEntity(userItem: userItem)

                            devices.forEach { deviceItem in

                                self.dataBaseManager.createDeviceEntity(deviceItem: deviceItem)
                            }
                            success(devices, userItem)
                        case .failure:
                            failure()
                        }
                    }
        }
    }

// MARK: - Device Item

private extension DeviceItem {
    init?(device: DeviceResponse.Device) {
        guard
            let deviceId = device.id,
            let name = device.deviceName,
            let type = ProductType(device: device)
            else { return nil }

        self.idNumber = "\(deviceId)"
        self.deviceName = name
        self.productType = type
    }
}

private extension DeviceItem {
    init?(device: DeviceAttributes) {
        guard
            let deviceId = device.deviceId,
            let name = device.name,
            let type = ProductType(device: device)
            else {
            return nil
        }

        self.idNumber = "\(deviceId)"
        self.deviceName = name
        self.productType = type
    }
}

// MARK: - ProductType

extension ProductType {
    init?(device: DeviceAttributes) {
        switch device.productType {
        case "Heater":
            guard
                let mode = device.mode,
                let temperature = device.temperature
                else { return nil }
            self = .heater(mode: mode, temperature: "\(temperature)")
        case "Light":
        guard
            let mode = device.mode,
            let intensity = device.intensity
            else { return nil }
        self = .light(mode: mode, intensity: "\(intensity)")
        case "RollerShutter":
        guard
            let position = device.position
            else { return nil }
        self = .rollerShutter(position: "\(position)")
        default: return nil
        }
    }
}

extension ProductType {
    init?(device: DeviceResponse.Device) {
        switch device.productType {
        case "Heater":
            guard
                let mode = device.mode,
                let temperature = device.temperature
                else { return nil }
            self = .heater(mode: mode, temperature: "\(temperature)")
        case "Light":
        guard
            let mode = device.mode,
            let intensity = device.intensity
            else { return nil }
        self = .light(mode: mode, intensity: "\(intensity)")
        case "RollerShutter":
        guard
            let position = device.position
            else { return nil }
        self = .rollerShutter(position: "\(position)")
        default: return nil
        }
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
