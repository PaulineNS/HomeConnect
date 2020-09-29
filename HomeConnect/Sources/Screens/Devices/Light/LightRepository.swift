//
//  LightRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol LightRepositoryType {
    
}

final class LightRepository: LightRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

}
