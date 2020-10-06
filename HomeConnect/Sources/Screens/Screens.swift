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

protocol DevicesScreensDelegate: class {
    func devicesScreensShouldDisplayAlert(for type: AlertType)
    func devicesScreenDidSelectDeleteButton()
    func devicesScreenDidSelectSaveButton()
    func devicesScreensShouldDisplayMultiChoicesAlert(for type: AlertType, completion: @escaping (Bool) -> Void)
}

protocol ProfileScreenDelegate: class {
    func profileScreenDidSelectUpdateProfileButton()
    func profileScreenDidSelectCloseButton()
}

protocol FiltersScreenDelegate: class {
    func filtersScreenDidSelectCloseButton()
    func filtersScreenDidSelectSearchButton(device: [DeviceItem])
    func filtersScreenShouldDisplayAlert(for type: AlertType)
}

protocol UpdateProfileScreensDelegate: class {
    func updateProfileScreenShouldDisplayAlert(for type: AlertType)
    func updateProfileScreenDidSelectSaveButton()
}

// MARK: - Home

extension Screens {

    func createHome(delegate: HomeScreenDelegate?) -> HomeViewController {
        let repository = HomeRepository(networkClient: context.client,
                                        dataBaseEngine: context.dataBaseEngine,
                                        checker: context.userDefaultchecker)
        let viewModel = HomeViewModel(repository: repository, delegate: delegate)
        return HomeViewController(viewModel: viewModel)
    }

}

// MARK: - Device Details

extension Screens {

    func createDeviceDetailViewController(deviceSelected: DeviceItem,
                                          delegate: DevicesScreensDelegate) -> UIViewController {
        switch deviceSelected.productType {
        case .heater:
            return createHeaterViewController(heaterSelected: deviceSelected,
                                              delegate: delegate)
        case .light:
            return createLightViewController(lightSelected: deviceSelected,
                                             delegate: delegate)
        case .rollerShutter:
            return createRollerShutterViewController(rollerShutterSelected: deviceSelected,
                                                     delegate: delegate)
        }
    }

    private func createHeaterViewController(heaterSelected: DeviceItem,
                                            delegate: DevicesScreensDelegate?) -> UIViewController {
        let repository = HeaterRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = HeaterViewModel(device: heaterSelected,
                                        repository: repository,
                                        delegate: delegate)
        return HeaterViewController(viewModel: viewModel)
    }

    private func createLightViewController(lightSelected: DeviceItem,
                                           delegate: DevicesScreensDelegate?) -> UIViewController {
        let repository = LightRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = LightViewModel(device: lightSelected,
                                       repository: repository,
                                       delegate: delegate)
        return LightViewController(viewModel: viewModel)
    }

    private func createRollerShutterViewController(rollerShutterSelected: DeviceItem,
                                                   delegate: DevicesScreensDelegate?) -> UIViewController {
        let repository = RollerShutterRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = RollerShutterViewModel(device: rollerShutterSelected,
                                               repository: repository,
                                               delegate: delegate)
        return RollerShutterViewController(viewModel: viewModel)
    }
}

// MARK: - Profile

extension Screens {

    func createProfileViewController(delegate: ProfileScreenDelegate?) -> UIViewController {
        let repository = ProfileRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = ProfileViewModel(repository: repository, delegate: delegate)
        return ProfileViewController(viewModel: viewModel)
    }
}

// MARK: - Filters

extension Screens {

    func createFilterViewController(delegate: FiltersScreenDelegate?) -> UIViewController {
        let repository = FiltersRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = FiltersViewModel(repository: repository, delegate: delegate)
        return FiltersViewController(viewModel: viewModel)

    }
}

// MARK: - Update Profile

extension Screens {

    func createUpdateProfileViewController(delegate: UpdateProfileScreensDelegate?) -> UIViewController {
        let repository = UpdateProfileRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = UpdateProfileViewModel(repository: repository,
                                               delegate: delegate)
        return UpdateProfileViewController(viewModel: viewModel)
    }
}

// MARK: - Simple Alert

extension Screens {

    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }

}

// MARK: - Multichoices Alert

extension Screens {

    func createMultiChoicesAlert(for type: AlertType, completion: @escaping (Bool) -> Void) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Oui", style: UIAlertAction.Style.default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        alertController.addAction(UIAlertAction(title: "Non", style: UIAlertAction.Style.default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
            completion(false)
        }))

        return alertController
    }

}
