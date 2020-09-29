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

    private func showDevicesDetail(device: DeviceItem) {
        let viewController = screens.createDeviceDetailViewController(deviceSelected: device, delegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showProfile() {
        let viewController = screens.createProfileViewController()
        navigationController.pushViewController(viewController, animated: true)// TODO: je ferais un present plutot
    }

    private func showFilter() {
        let viewController = screens.createFilterViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - Alert

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }

}

extension HomeCoordinator: HomeScreenDelegate {

    func homeScreenDidSelectDevice(device: DeviceItem) {
        showDevicesDetail(device: device)
    }

    func homeScreenDidSelectProfile() {
        showProfile()
    }

    func homeScreenDidSelectFilter() {
        showFilter()
    }

    func homeScreenShouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }

}

extension HomeCoordinator: DevicesScreensDelegate {
    func devicesScreensShouldDisplayAlert(for type: AlertType) {
        showAlert(for: type)
    }
    
    
}

//extension HomeCoordinator: LightScreenDelegate {
//    func lightScreenDidDeleteDevice(device: DeviceItem) {
//        print("")
//    }
//}
//
//extension HomeCoordinator: RollerShutterScreenDelegate {
//    func rollerScreenDidDeleteDevice(device: DeviceItem) {
//        print("")
//    }
//}
//
//extension HomeCoordinator: HeaterScreenDelegate {
//    func heaterScreenDidDeleteDevice(device: DeviceItem) {
//        print("")
//    }
//}
