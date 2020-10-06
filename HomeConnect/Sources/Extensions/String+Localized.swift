//
//  String+Localized.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 06/10/2020.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
