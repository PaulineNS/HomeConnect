//
//  HomeCoordinator.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import UIKit

final class HomeCoordinator {

    // MARK: - Properties

    private let presenter: UIWindow
    private let navigationController: UINavigationController
    private let screens: Screens

    // MARK: - Init

    init(presenter: UIWindow,
         context: Context) {
        self.presenter = presenter
        self.navigationController = UINavigationController(nibName: nil, bundle: nil)
        self.screens = Screens(context: context)
    }

    // MARK: - Coordinator

    func start() {
        presenter.rootViewController = navigationController
        showHome()
    }

    // MARK: - Home

    private func showHome() {
        let viewController = screens.createHome(delegate: self)
        navigationController.viewControllers = [viewController]
    }

    // MARK: - Alert

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }

}

extension HomeCoordinator: HomeScreenDelegate {

    func homeScreenShouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }

}
