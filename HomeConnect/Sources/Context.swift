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
    let dataBaseEngine: DataBaseEngine
    let userDefaultchecker: UserDefaultChecker

    // MARK: - Initializer

    private init() {
        self.engine = HTTPEngine()
        self.client = HTTPClient(engine: engine)
        self.requestCancellation = RequestCancellationToken()
        self.dataBaseStack = DataBaseStack(modelName: "HomeConnect")
        self.dataBaseEngine = DataBaseEngine(dataBaseStack: dataBaseStack)
        self.userDefaultchecker = UserDefaultChecker()
    }

    // MARK: - Build

    class func build() -> Context {
        return Context()
    }

}
