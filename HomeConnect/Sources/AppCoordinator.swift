//
//  AppCoordinator.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class AppCoordinator {

    // MARK: - Private properties

    private unowned var appDelegate: AppDelegate
    private let context: Context
    private var homeCoordinator: HomeCoordinator?

    // MARK: - Initializer

    init(appDelegate: AppDelegate,
         context: Context) {
        self.appDelegate = appDelegate
        self.context = context
    }

    // MARK: - Coordinator

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()

        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }

        showHome()
    }

    private func showHome() {
        homeCoordinator = HomeCoordinator(presenter: appDelegate.window!,
                                          context: context)
        homeCoordinator?.start()
    }
}
