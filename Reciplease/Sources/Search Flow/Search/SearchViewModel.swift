//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import Foundation

final class SearchViewModel {

    // MARK: Private properties

    private let repository: SearchRepositoryType
    private weak var delegate: SearchViewControllerDelegate?

    // MARK: - Initializer

    init(
        repository: SearchRepositoryType,
        delegate: SearchViewControllerDelegate
    ) {
        self.repository = repository
        self.delegate = delegate
    }
   
    // MARK: - Properties


    // MARK: - Outputs

    // MARK: - Inputs

    func viewDidLoad() {
        
    }

    func didPressSearch() {
        delegate?.didPressSearch()
    }

    // MARK: - Utils

// MARK: - Extension

}
