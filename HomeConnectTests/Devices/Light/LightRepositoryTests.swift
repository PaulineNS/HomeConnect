//
//  LightRepositoryTests.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import XCTest
@ testable import HomeConnect

// MARK: - Mock

class MockLightUserDefaultChecker: UserDefaultsType {
    func bool(forKey defaultName: String) -> Bool {
        true
    }

    func set(_ value: Bool, forKey defaultName: String) {
    }
}

class LightRepositoryTests: XCTestCase {

}
