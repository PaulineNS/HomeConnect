//
//  ProductType.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 27/09/2020.
//

import Foundation

enum ProductType: Equatable {
    case heater(mode: String, temperature: String)
    case light(mode: String, intensity: String)
    case rollerShutter(position: String)

    var imageName: String {
        switch self {
        case .heater:
            return "heater"
        case .light:
            return "light"
        case .rollerShutter:
            return "rollerShutter"
        }
    }

    var name: String {
        switch self {
        case .heater:
            return "Heater"
        case .light:
            return "Light"
        case .rollerShutter:
            return "RollerShutter"
        }
    }

}
