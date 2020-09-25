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
    func getAllDevices(callback: @escaping (Device) -> Void, failure: @escaping (() -> Void))
}

final class HomeRepository: HomeRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClientType

    private let token: RequestCancellationToken

    let dependanceType: DependanceType

//    private let errorHandler = URLRequestBuilder

    private let cancellationToken = RequestCancellationToken()

    // MARK: - Init

    init(networkClient: HTTPClientType,
         token: RequestCancellationToken,
         dependanceType: DependanceType) {
        self.networkClient = networkClient
        self.token = token
        self.dependanceType = dependanceType
    }

    func getAllDevices(callback: @escaping (Device) -> Void,
                       failure: @escaping (() -> Void)) {
        switch dependanceType {
        case .network:
            guard let url = URL(string: "https://storage42.com/modulotest/data.json") else {
                return
            }
            networkClient.request(requestType: .GET,
                                  url: url,
                                  cancelledBy: token ) { (result: Result<Device, HTTPClientError>) in
                switch result {
                case .success(let response):
                    callback(response)
                case .failure:
                    failure()
                }
            }
        case .persistence:
            print("")
        }
    }
}
