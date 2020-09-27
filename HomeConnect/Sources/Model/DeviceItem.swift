//
//  DeviceItem.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

struct DeviceItem: Equatable {
    let idNumber: String?
    let deviceName: String?
    let intensity: String?
    let mode: String?
    let productType: ProductType?
    let position, temperature: String?
    let user: UserAttributes
}
