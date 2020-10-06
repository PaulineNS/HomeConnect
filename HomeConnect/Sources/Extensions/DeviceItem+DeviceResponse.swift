//
//  DeviceItem+DeviceResponse.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import Foundation

// MARK: - Init DeviceItem with DeviceResponse

extension DeviceItem {
    init?(device: DeviceResponse.Device) {
        guard
            let deviceId = device.deviceId,
            let name = device.deviceName,
            let type = ProductType(device: device)
            else { return nil }

        self.idNumber = "\(deviceId)"
        self.deviceName = name
        self.productType = type
    }
}
