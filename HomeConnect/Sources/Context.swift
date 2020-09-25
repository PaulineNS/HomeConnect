//
//  Context.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class Context {

    // MARK: - Properties

    let client: HTTPClientType
    let engine: HTTPEngineType
    let requestCancellation: RequestCancellationToken

    // MARK: - Initializer

    private init() {
        self.engine = HTTPEngine()
        self.client = HTTPClient(engine: engine)
        self.requestCancellation = RequestCancellationToken()
    }

    // MARK: - Build

    class func build() -> Context {
        return Context()
    }

}
