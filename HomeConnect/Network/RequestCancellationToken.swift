//
//  RequestCancellationToken.swift
//  HomeConnect
//
//  Created by Pauline Nomballais on 24/09/2020.
//

import Foundation

final class RequestCancellationToken {

    init() {}

    var willDealocate: (() -> Void)?

    deinit {
        willDealocate?()
    }
}
