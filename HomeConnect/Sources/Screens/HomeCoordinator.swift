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
    private var profileNavigationController: UINavigationController?
    private var filterNavigationController: UINavigationController?
    private var homeViewController: HomeViewController?

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
        homeViewController = screens.createHome(delegate: self)
        guard let homeViewController = homeViewController else { return }
        navigationController.viewControllers = [homeViewController]
    }

    private func showDevicesDetail(device: DeviceItem) {
        let viewController = screens.createDeviceDetailViewController(deviceSelected: device, delegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showProfile() {
        let viewController = screens.createProfileViewController(delegate: self)
        profileNavigationController = UINavigationController(nibName: nil, bundle: nil)
        profileNavigationController = UINavigationController(rootViewController: viewController)
        profileNavigationController?.modalPresentationStyle = .fullScreen
        guard let profileNavigation = profileNavigationController else { return }
        self.navigationController.present(profileNavigation, animated: true, completion: nil)
    }

    private func showFilter() {
        let viewController = screens.createFilterViewController(delegate: self)
        filterNavigationController = UINavigationController(nibName: nil, bundle: nil)
        filterNavigationController = UINavigationController(rootViewController: viewController)
        filterNavigationController?.modalPresentationStyle = .fullScreen
        guard let filterNavigation = filterNavigationController else { return }
        self.navigationController.present(filterNavigation, animated: true, completion: nil)
    }

    private func showUpdateProfile() {
        let viewController = screens.createUpdateProfileViewController(delegate: self)
        profileNavigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - SimpleAlert

    private func showSimpleAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }

    // MARK: - MultiChoicesAlert

    private func showMultiChoiseAlert(for type: AlertType, completion: @escaping (Bool) -> Void) {
        let alert = screens.createMultiChoicesAlert(for: type, completion: completion)
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
        showSimpleAlert(for: type)
    }

}

extension HomeCoordinator: DevicesScreensDelegate {

    func devicesScreenDidSelectDeleteButton() {
        self.navigationController.popViewController(animated: true)
    }

    func devicesScreenDidSelectSaveButton() {
        self.navigationController.popViewController(animated: true)
    }

    func devicesScreensShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }

    func devicesScreensShouldDisplayMultiChoicesAlert(for type: AlertType, completion: @escaping (Bool) -> Void) {
        showMultiChoiseAlert(for: type, completion: completion)
    }

}

extension HomeCoordinator: ProfileScreenDelegate {
    func profileScreenDidSelectCloseButton() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func profileScreenDidSelectUpdateProfileButton() {
        showUpdateProfile()
    }
}

extension HomeCoordinator: FiltersScreenDelegate {
    func filtersScreenShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }
    
    func filtersScreenDidSelectSearchButton(device: [DeviceItem]) {
        homeViewController?.didSelectFilters(deviceItems: device)
        navigationController.dismiss(animated: true, completion: nil)
    }

    func filtersScreenDidSelectCloseButton() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

extension HomeCoordinator: UpdateProfileScreensDelegate {

    func updateProfileScreenShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }

    func updateProfileScreenDidSelectSaveButton() {
        self.profileNavigationController?.popViewController(animated: true)
    }
}
