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
    func getAllDevices(callback: @escaping ([DeviceItem]) -> Void, failure: @escaping (() -> Void))
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

    func getAllDevices(callback: @escaping ([DeviceItem]) -> Void,
                       failure: @escaping (() -> Void)) {
        switch dependanceType {
        case .network:
            guard let url = URL(string: "http://storage42.com/modulotest/data.json") else {
                return
            }
            networkClient.request(requestType: .GET,
                                  url: url,
                                  cancelledBy: token ) { (result: Result<DeviceResponse, HTTPClientError>) in
                switch result {
                case .success(let response):
                    if let deviceItems = self.convertObjectDevice(from: response) {
                        callback(deviceItems)
                    }
                case .failure:
                    failure()
                }
            }
        case .persistence:
            print("")
        }
    }

    func convertObjectDevice(from device: DeviceResponse) -> [DeviceItem]? {
        let devices = device.devices.map {
            $0.map { device in
                DeviceItem(idNumber: device.idNumber,
                           deviceName: device.deviceName,
                           intensity: device.intensity,
                           mode: device.mode,
                           productType: device.productType?.rawValue ?? "",
                           position: device.position,
                           temperature: device.temperature)
            }
        }
        return devices
    }
}
