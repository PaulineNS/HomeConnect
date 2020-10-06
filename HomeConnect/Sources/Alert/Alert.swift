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
    case noUserError
    case maximumTemperatureReached
    case minimumTemperatureReached
    case deleteDevice
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "😲",
                         message: "alert_networkError".localized)
        case .noDevicesError:
            self = Alert(title: "🔄",
                         message: "alert_no_devices".localized)
        case .maximumTemperatureReached:
            self = Alert(title: "🔥",
                         message: "alert_max_temperature".localized)
        case .minimumTemperatureReached:
            self = Alert(title: "🥶",
                         message: "alert_min_temperature".localized)
        case .deleteDevice:
            self = Alert(title: "🗑️",
                         message: "alert_deletion".localized)
        case .noUserError:
            self = Alert(title: "😶",
                         message: "alert_no_user".localized)
        }
    }
}
