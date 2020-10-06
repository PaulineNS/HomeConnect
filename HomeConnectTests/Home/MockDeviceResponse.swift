//
//  MockDeviceResponse.swift
//  HomeConnectTests
//
//  Created by Pauline Nomballais on 06/10/2020.
//

@testable import HomeConnect
import Foundation

var mockDeviceResponseJSONData = """
{
    "devices": [
        {
            "id": 1,
            "deviceName": "Lampe - Cuisine",
            "intensity": 50,
            "mode": "ON",
            "productType": "Light"
        },
        {
            "id": 2,
            "deviceName": "Volet roulant - Salon",
            "position": 70,
            "productType": "RollerShutter"
        },
        {
            "id": 3,
            "deviceName": "Radiateur - Chambre",
            "mode": "OFF",
            "temperature": 20,
            "productType": "Heater"
        },
        {
            "id": 4,
            "deviceName": "Lampe - Salon",
            "intensity": 100,
            "mode": "ON",
            "productType": "Light"
        },
        {
            "id": 5,
            "deviceName": "Volet roulant",
            "position": 0,
            "productType": "RollerShutter"
        },
        {
            "id": 6,
            "deviceName": "Radiateur - Salon",
            "mode": "OFF",
            "temperature": 18,
            "productType": "Heater"
        },
        {
            "id": 7,
            "deviceName": "Lampe - Grenier",
            "intensity": 0,
            "mode": "ON",
            "productType": "Light"
        },
        {
            "id": 8,
            "deviceName": "Volet roulant - Salle de bain",
            "position": 70,
            "productType": "RollerShutter"
        },
        {
            "id": 9,
            "deviceName": "Radiateur - Salle de bain",
            "mode": "OFF",
            "temperature": 20,
            "productType": "Heater"
        },
        {
            "id": 10,
            "deviceName": "Lampe - Salle de bain",
            "intensity": 36,
            "mode": "ON",
            "productType": "Light"
        },
        {
            "id": 11,
            "deviceName": "Volet roulant",
            "position": 33,
            "productType": "RollerShutter"
        },
        {
            "id": 12,
            "deviceName": "Radiateur - WC",
            "mode": "ON",
            "temperature": 19,
            "productType": "Heater"
        }
    ],
    "user": {
        "firstName": "John",
        "lastName": "Doe",
        "address": {
            "city": "Issy-les-Moulineaux",
            "postalCode": 92130,
            "street": "rue Michelet",
            "streetCode": "2B",
            "country": "France"
        },
        "birthDate": 813766371000
    }
}
""".data(using: .utf8)!

var mockDeviceResponse = try? JSONDecoder().decode(DeviceResponse.self, from: mockDeviceResponseJSONData)
