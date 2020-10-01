//
//  HTTPClient.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
}

enum HTTPClientError: Error {
    case unableToParseToJSON(Data)
    case random
    case missingData
    case generic(Error)
}

protocol HTTPClientType: class {
    func request<T: Decodable>(
                    requestType: RequestType,
                    url: URL,
                    cancelledBy token: RequestCancellationToken,
                    completion: @escaping (Result<T, HTTPClientError>) -> Void
    )
}

final class HTTPClient: HTTPClientType {

    // MARK: - Properties

    private let engine: HTTPEngineType
    private let jsonDecoder: JSONDecoder

    // MARK: - Init

    init(engine: HTTPEngineType) {
        self.engine = engine
        self.jsonDecoder = JSONDecoder()
    }

    // MARK: - HTTPClientType protocol

    func request<T: Decodable>(
        requestType: RequestType,
        url: URL,
        cancelledBy token: RequestCancellationToken,
        completion: @escaping (Result<T, HTTPClientError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue

        engine.send(request: request, cancelledBy: token) { (data, _, error) in
            if let error = error {
                completion(.failure(.generic(error)))
                return
            } else if let data = data {
                self.decodeJSON(data: data) { (result: T) in
                    completion(.success(result))
                }
            } else {
                completion(.failure(.missingData))
            }
        }
    }

    private func decodeJSON<T: Decodable>(
        data: Data,
        completion: @escaping (T) -> Void
    ) {
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            print("Decoder was unable to decode: \(T.self)")
            return
        }
        completion(decodedData)
    }
}
