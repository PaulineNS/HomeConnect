//
//  HomeCellViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 28/09/2020.
//

import Foundation

struct HomeCellViewModel {

    // MARK: - Properties

    struct VisibleDevice {
        let name: String
        let type: ProductType
    }

    private let device: VisibleDevice

    init(device: VisibleDevice) {
        self.device = device
    }

    // MARK: - Outputs

    var deviceName: ((String) -> Void)?
    var imageName: ((String) -> Void)?
    var deviceType: ((ProductType) -> Void)?

    // MARK: - Outputs

    func didUpdateCell() {
        deviceName?(device.name)
        imageName?(device.type.imageName)
        deviceType?(device.type)
    }
}
