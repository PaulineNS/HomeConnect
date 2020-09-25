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
    let productType: String
    let position, temperature: Int?

    static func == (parameterLhs: DeviceItem, parameterRhs: DeviceItem) -> Bool {
        return parameterLhs.idNumber == parameterRhs.idNumber
            && parameterLhs.deviceName == parameterRhs.deviceName
            && parameterLhs.intensity == parameterRhs.intensity
            && parameterLhs.mode == parameterRhs.mode
            && parameterLhs.productType == parameterRhs.productType
            && parameterLhs.position == parameterRhs.position
            && parameterLhs.temperature == parameterRhs.temperature
    }
}
