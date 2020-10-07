//
//  ProductType+DeviceResponse.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import Foundation

// MARK: - Init ProductType with DeviceResponse

extension ProductType {
    init?(device: DeviceResponse.Device) {
        switch device.productType {
        case "Heater":
            guard
                let mode = device.mode,
                let temperature = device.temperature
                else { return nil }
            self = .heater(mode: mode,
                           temperature: "\(temperature)")
        case "Light":
        guard
            let mode = device.mode,
            let intensity = device.intensity
            else { return nil }
        self = .light(mode: mode,
                      intensity: "\(intensity)")
        case "RollerShutter":
        guard
            let position = device.position
            else { return nil }
        self = .rollerShutter(position: "\(position)")
        default: return nil
        }
    }
}
