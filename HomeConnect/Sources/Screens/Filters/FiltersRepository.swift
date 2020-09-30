//
//  FiltersRepository.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 30/09/2020.
//

import Foundation

protocol FiltersRepositoryType: class {

}

final class FiltersRepository: FiltersRepositoryType {

    // MARK: - Properties

    private let dataBaseManager: DataBaseManager

    // MARK: - Init

    init(dataBaseManager: DataBaseManager) {
        self.dataBaseManager = dataBaseManager
    }

}
