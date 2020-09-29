//
//  HeaterRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol HeaterRepositoryType {
    func deleteItem(with deviceId: String)
}

final class HeaterRepository: HeaterRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

    // MARK: - HeaterRepositoryType

    func deleteItem(with deviceId: String) {
        dataBaseManager.deleteADevice(with: deviceId)
    }

}
