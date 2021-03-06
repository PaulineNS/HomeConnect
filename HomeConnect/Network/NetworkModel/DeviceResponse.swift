//
//  DeviceResponse.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

// MARK: - DeviceResponse
struct DeviceResponse: Decodable {
    let devices: [Device]?
    let user: User?

    // MARK: - Device
    struct Device: Decodable {
        let deviceId: Int?
        let deviceName: String?
        let intensity: Int?
        let mode: String?
        let productType: String?
        let position, temperature: Int?

        enum CodingKeys: String, CodingKey {
            case deviceId = "id"
            case deviceName
            case intensity
            case mode
            case productType
            case position
            case temperature
        }
    }

    // MARK: - User
    struct User: Decodable {
        let firstName, lastName: String?
        let address: Address?
        let birthDate: Int?

        // MARK: - Address
        struct Address: Decodable {
            let city: String?
            let postalCode: Int?
            let street, streetCode, country: String?
        }
    }
}
