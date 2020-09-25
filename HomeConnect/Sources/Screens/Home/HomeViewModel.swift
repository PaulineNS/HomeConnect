//
//  HomeViewModel.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class HomeViewModel {

    // MARK: - Outputs

    var homeTitle: ((String) -> Void)?

    func viewDidLoad() {
        homeTitle?("Mes Objects connectés")
    }

    func didSelectItem(at index: Int) {
    }

}
