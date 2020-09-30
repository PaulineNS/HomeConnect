//
//  FiltersViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class FiltersViewModel {

    // MARK: - Private properties

    private let repository: FiltersRepositoryType

    // MARK: - Initializer

    init(repository: FiltersRepositoryType) {
        self.repository = repository
    }
}
