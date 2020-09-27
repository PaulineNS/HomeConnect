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
    func homeScreenShouldDisplayAlert(for type: AlertType)
}

// MARK: - Home

extension Screens {

    func createHome(delegate: HomeScreenDelegate?) -> UIViewController {

//        if firstOpen {
//
//        }
        let repository = HomeRepository(networkClient: context.client,
                                        token: context.requestCancellation,
                                        dependanceType: .network,
                                        dataBaseManager: context.dataBaseManager)
        let viewModel = HomeViewModel(repository: repository, delegate: delegate)
        return HomeViewController(viewModel: viewModel)

//        else {
//            let repository = HomeRepository(networkClient: context.client,
//        token: context.requestCancellation,
//        dependanceType: .persistence)
//            let viewModel = HomeViewModel(repository: repository, delegate: delegate)
//            return HomeViewController(viewModel: viewModel)
//        }
    }

}

// MARK: - Device Details

extension Screens {

    func createDeviceDetailViewController(deviceSelected: DeviceItem) -> UIViewController {

        switch deviceSelected.productType {
        case .heater:
            return HeaterViewController()
        case .light:
            return LightViewController()
        case .rollerShutter:
            return RollerShutterViewController()
        case .none:
            return UIViewController()
        }

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
