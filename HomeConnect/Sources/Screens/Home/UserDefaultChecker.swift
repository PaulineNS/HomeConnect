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
