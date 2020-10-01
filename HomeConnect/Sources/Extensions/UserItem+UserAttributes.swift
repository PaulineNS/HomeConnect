//
//  UserItem+UserAttributes.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import Foundation

// MARK: - Init UserItem with UserAttributes

extension UserItem {
    init(user: UserAttributes) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthDate = user.birthDate
        self.city = user.city
        self.postalCode = Int(user.postalCode ?? "")
        self.street = user.street
        self.streetCode = user.streetCode
        self.country = user.country
    }
}
