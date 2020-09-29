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

// MARK: - Fetch Devices

protocol HomeScreenDelegate: class {
    func homeScreenDidSelectDevice(device: DeviceItem)
    func homeScreenDidSelectProfile()
    func homeScreenDidSelectFilter()
    func homeScreenShouldDisplayAlert(for type: AlertType)
}

// MARK: - Home

extension Screens {

    func createHome(delegate: HomeScreenDelegate?) -> UIViewController {
        let repository = HomeRepository(networkClient: context.client,
                                        token: context.requestCancellation,
                                        dependanceType: .network,
                                        dataBaseManager: context.dataBaseManager,
                                        checker: context.userDefaultchecker)
        let viewModel = HomeViewModel(repository: repository, delegate: delegate)
        return HomeViewController(viewModel: viewModel)
    }

}

// MARK: - Device Details

extension Screens {
    func createDeviceDetailViewController(deviceSelected: DeviceItem) -> UIViewController {
        switch deviceSelected.productType {
        case .heater:
            return createHeaterViewController(heaterSelected: deviceSelected)
        case .light:
            return createLightViewController(lightSelected: deviceSelected)
        case .rollerShutter:
            return createRollerShutterViewController(rollerShutterSelected: deviceSelected)
        }
    }

    private func createHeaterViewController(heaterSelected: DeviceItem) -> UIViewController {
        let repository = HeaterRepository(dataBaseManager: context.dataBaseManager)
        let viewModel = HeaterViewModel(device: heaterSelected,
                                        repository: repository)
        return HeaterViewController(viewModel: viewModel)
    }

    private func createLightViewController(lightSelected: DeviceItem) -> UIViewController {
        let repository = LightRepository(dataBaseManager: context.dataBaseManager)
        let viewModel = LightViewModel(device: lightSelected,
                                       repository: repository)
        return LightViewController(viewModel: viewModel)
    }

    private func createRollerShutterViewController(rollerShutterSelected: DeviceItem) -> UIViewController {
        let repository = RollerShutterRepository(dataBaseManager: context.dataBaseManager)
        let viewModel = RollerShutterViewModel(device: rollerShutterSelected,
                                               repository: repository)
        return RollerShutterViewController(viewModel: viewModel)
    }
}

// MARK: - Profile

extension Screens {

    func createProfileViewController() -> UIViewController {
        let repository = ProfileRepository(dataBaseManager: context.dataBaseManager)
        let viewModel = ProfileViewModel(repository: repository)
        return ProfileViewController(viewModel: viewModel)
    }
}

// MARK: - Filters

extension Screens {

    func createFilterViewController() -> UIViewController {
        return FiltersViewController()
    }
}

// MARK: - Alert

extension Screens {

    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }

}
