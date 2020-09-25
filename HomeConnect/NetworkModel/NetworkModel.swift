//
//  Device.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

// MARK: - Device
struct Device: Codable {
    let devices: [DeviceElement]
    let user: User
}

// MARK: - DeviceElement
struct DeviceElement: Codable {
    let deviceId: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: ProductType
    let position, temperature: Int?
}

enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
