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

    func request<T>(requestType: RequestType,
                    url: URL,
                    cancelledBy token: RequestCancellationToken,
                    completion: @escaping (Result<T, HTTPClientError>) -> Void) where T: Decodable {
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else { return }

            completion(.success(decodedData))
        } catch {
            completion(.failure(.missingData))
        }
    }
}
