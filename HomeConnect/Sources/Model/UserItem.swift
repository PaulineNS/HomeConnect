//
//  UserItem.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 27/09/2020.
//

import Foundation

struct UserItem: Equatable {
    let firstName, lastName: String?
    let birthDate: String?
    let city: String?
    let postalCode: Int?
    let street, streetCode, country: String?
}
