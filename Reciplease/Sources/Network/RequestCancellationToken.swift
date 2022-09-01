//
//  RequestCancellationToken.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/09/2022.
//

import Foundation

final class RequestCancellationToken {
    // MARK: - Init

    init() {}

    // MARK: - Deinit

    deinit {
        willDealocate?()
    }

    // MARK: - Properties

    var willDealocate: (() -> Void)?
}
