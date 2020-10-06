//
//  MockHTTPClient.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation
import XCTest
@testable import HomeConnect

// MARK: - Mock

class MockHTTPClient: HTTPClientType {

    var response: Decodable! = nil
    var error: HTTPClientError! = nil

    func request<T>(requestType: RequestType,
                    url: URL,
                    cancelledBy token: RequestCancellationToken,
                    completion: @escaping (Result<T, HTTPClientError>) -> Void) where T: Decodable {
        if error == nil {
            guard let reponse =  response as? T else {return}
            completion(.success(reponse))
        } else {
            completion(.failure(error))
        }
    }
}
