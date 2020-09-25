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
    func getAllDevices(callback: @escaping (DeviceResponse) -> Void, failure: @escaping (() -> Void))
}

final class HomeRepository: HomeRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClientType

    private let token: RequestCancellationToken

    let dependanceType: DependanceType

    // MARK: - Init

    init(networkClient: HTTPClientType,
         token: RequestCancellationToken,
         dependanceType: DependanceType) {
        self.networkClient = networkClient
        self.token = token
        self.dependanceType = dependanceType
    }

    func getAllDevices(callback: @escaping (DeviceResponse) -> Void,
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
                    callback(response)
                    // put inside data base
                case .failure:
                    failure()
                }
            }
        case .persistence:
            print("")
        }
    }
}
