//
//  DeviceItem.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

struct DeviceItem: Equatable {
    let idNumber: Int?
    let deviceName: String?
    let intensity: Int?
    let mode: String?
    let productType: ProductType?
    let position, temperature: Int?
}
