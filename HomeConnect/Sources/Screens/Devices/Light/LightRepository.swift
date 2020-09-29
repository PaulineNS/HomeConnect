//
//  LightRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol LightRepositoryType {
    func deleteItem(with deviceId: String)
}

final class LightRepository: LightRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }
    
    // MARK: - LightRepositoryType

    func deleteItem(with deviceId: String) {
        dataBaseManager.deleteADevice(with: deviceId)
    }

}
