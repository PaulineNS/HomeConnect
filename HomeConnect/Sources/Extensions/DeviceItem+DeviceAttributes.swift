//
//  DeviceItem+DeviceAttributes.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 01/10/2020.
//

import Foundation

// MARK: - Init DeviceItem with DeviceAttributes

extension DeviceItem {
    init?(device: DeviceAttributes) {
        guard
            let deviceId = device.deviceId,
            let name = device.name,
            let type = ProductType(device: device)
            else {
            return nil
        }

        self.idNumber = "\(deviceId)"
        self.deviceName = name
        self.productType = type
    }
}
