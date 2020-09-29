//
//  RollerShutterRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 29/09/2020.
//

import Foundation

protocol RollerShutterRepositoryType {

}

final class RollerShutterRepository: RollerShutterRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init( dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

}
