//
//  HTTPEngine.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

typealias HTTPCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalideURLResponse
}

protocol HTTPEngineType {
    func send(request: URLRequest,
              cancelledBy token: RequestCancellationToken,
              callback: @escaping HTTPCompletionHandler)
}

final class HTTPEngine: HTTPEngineType {

    private let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func send(request: URLRequest,
              cancelledBy token: RequestCancellationToken,
              callback: @escaping HTTPCompletionHandler) {
        let task = session.dataTask(with: request) { (data, urlResponse, _) in
            if urlResponse != nil, let httpUrlResponse = urlResponse as? HTTPURLResponse {
                callback(data, httpUrlResponse, nil)
            } else {
                callback(data, nil, URLSessionEngineError.invalideURLResponse)
            }
        }
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}
