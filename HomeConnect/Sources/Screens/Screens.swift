//
//  Screens.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class Screens {

    // MARK: - Properties

    private let context: Context

    // MARK: - Initializer

    init(context: Context) {
        self.context = context
    }
}

// Home

extension Screens {

    func createHome() -> UIViewController {
        return HomeViewController()
    }

}
