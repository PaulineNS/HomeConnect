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
                         message: "Veuillez réesayer ultérieurement...")
        case .noDevicesError:
            self = Alert(title: "🔄",
                         message: "Pas d'objet trouvés. Veuillez réinitialiser votre comptre dans votre profil.")
        case .maximumTemperatureReached:
            self = Alert(title: "🔥",
                         message: "Vous avez atteint la température maximale")
        case .minimumTemperatureReached:
            self = Alert(title: "🥶",
                         message: "Vous avez atteint la température minimale")
        case .deleteDevice:
            self = Alert(title: "🗑️",
                         message: "Voulez-vous vraiment supprimer cet objet ?")
        }
    }
}
