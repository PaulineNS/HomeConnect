//
//  UserItem+DeviceResponse.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import Foundation

extension UserItem {
    init(user: DeviceResponse.User) {
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.birthDate = Double(user.birthDate ?? 0).convertTimestampToStringDate()
        self.city = user.address?.city
        self.postalCode = user.address?.postalCode
        self.street = user.address?.street
        self.streetCode = user.address?.streetCode
        self.country = user.address?.country
    }
}
