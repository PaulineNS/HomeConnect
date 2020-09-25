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
    func getAllDevices(success: @escaping ([DeviceItem]) -> Void, failure: @escaping (() -> Void))
}

final class HomeRepository: HomeRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClientType
    private let token: RequestCancellationToken
    private let dependanceType: DependanceType

    // MARK: - Init

    init(networkClient: HTTPClientType,
         token: RequestCancellationToken,
         dependanceType: DependanceType) {
        self.networkClient = networkClient
        self.token = token
        self.dependanceType = dependanceType
    }
    
    // MARK: - HomeRepositoryType
    
    func getAllDevices(
        success: @escaping ([DeviceItem]) -> Void,
        failure: @escaping (() -> Void)
    ){
        switch dependanceType {
        case .network:
            executeNetworkRequest(success: success, failure: failure)
        case .persistence:
            print("")
        }
    }

    private func executeNetworkRequest(
        success: @escaping ([DeviceItem]) -> Void,
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
                success(devices)
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

// A deplacer
enum ProductType: String {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}
