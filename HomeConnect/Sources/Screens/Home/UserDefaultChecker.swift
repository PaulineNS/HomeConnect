//
//  UserDefaultChecker.swift
//  HomeConnect
//
//  Created by Bertrand BLOC'H on 28/09/2020.
//

import Foundation

protocol UserDefaultsType {
    func bool(forKey defaultName: String) -> Bool
    func set(_ value: Bool, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsType {}

struct UserDefaultChecker {

    private let userdefault: UserDefaultsType

    private static let firstLaunchKey = "hasAlreadyBeenLaunched"

    init(userdefault: UserDefaultsType = UserDefaults.standard) {
        self.userdefault = userdefault
    }

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
