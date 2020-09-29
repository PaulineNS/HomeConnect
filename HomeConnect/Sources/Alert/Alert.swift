//
//  Alert.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 25/09/2020.
//

import Foundation

enum AlertType: Equatable {
    case networkError
    case noDevicesError
    case maximumTemperatureReached
    case minimumTemperatureReached
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "Alert", message: "A very very bad thing happened.. 🙈")
        case .noDevicesError:
            self = Alert(title: "Alert", message: "No devices found. Try to reset your account in your profile")
        case .maximumTemperatureReached:
            self = Alert(title: "Alert", message: "Too hot")
        case .minimumTemperatureReached:
            self = Alert(title: "Alert", message: "Too cold")
        }
    }
}
