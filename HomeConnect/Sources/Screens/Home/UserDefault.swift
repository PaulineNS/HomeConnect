//
//  UserDefault.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 06/10/2020.
//

import Foundation

protocol UserDefaultsType {
    func bool(forKey defaultName: String) -> Bool
    func set(_ value: Bool, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsType {}

protocol UserDefaultCheckerType {
    func hasAlreadyBeenLaunched() -> Bool
}

struct UserDefaultChecker: UserDefaultCheckerType {

    // MARK: - Properties

    private let userdefault: UserDefaultsType
    private static let firstLaunchKey = "hasAlreadyBeenLaunched"

    // MARK: - Init

    init(userdefault: UserDefaultsType = UserDefaults.standard) {
        self.userdefault = userdefault
    }

    // MARK: - Public Methods

    func hasAlreadyBeenLaunched() -> Bool {
        var hasBeenLaunched: Bool = false
        if !userdefault.bool(forKey: UserDefaultChecker.firstLaunchKey) {
            hasBeenLaunched = false
            userdefault.set(true, forKey: UserDefaultChecker.firstLaunchKey)
        } else {
            hasBeenLaunched = true
        }
        return hasBeenLaunched
    }
}
