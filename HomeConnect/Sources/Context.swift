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
    let dataBaseStack: DataBaseStack
    let dataBaseManager: DataBaseManager

    // MARK: - Initializer

    private init() {
        self.engine = HTTPEngine()
        self.client = HTTPClient(engine: engine)
        self.requestCancellation = RequestCancellationToken()
        self.dataBaseStack = DataBaseStack(modelName: "HomeConnect")
        self.dataBaseManager = DataBaseManager(dataBaseStack: dataBaseStack)
    }

    // MARK: - Build

    class func build() -> Context {
        return Context()
    }

}
