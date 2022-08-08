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
    public var ingredients: [String] = [] {
        didSet {
            items?(ingredients)
        }
    }

    // MARK: - Initializer

    init(
        repository: SearchRepositoryType,
        delegate: SearchViewControllerDelegate
    ) {
        self.repository = repository
        self.delegate = delegate
        self.ingredients = []
    }

    // MARK: - Outputs
    
    var titleText: ((String) -> Void)?
    var searchPlaceholderText: ((String) -> Void)?
    var subtitleText: ((String) -> Void)?
    var addButtonText: ((String) -> Void)?
    var clearButtonText: ((String) -> Void)?
    var searchButtontext: ((String) -> Void)?
    var items: (([String]) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        titleText?(Constants.title)
        searchPlaceholderText?(Constants.searchPlaceholder)
        subtitleText?(Constants.subtitle)
        addButtonText?(Constants.addButton)
        clearButtonText?(Constants.clearButton)
        searchButtontext?(Constants.searchButton)
        ingredients = []
    }

    func didPressSearch() {
        repository.getRecipe(for: ingredients, callback: { [weak self] result in
            switch result {
            case let .success(response):
                delegate?.didPressSearch()
            case let .failure(error):
                fatalError(error.localizedDescription)
            }
        })
    }
    
    func didPressAdd(item: String) {
        guard !ingredients.contains(item) else { return }
        ingredients.append(item)
    }
    
    func didPressClear() {
        ingredients.removeAll()
    }
}

private extension SearchViewModel {
    enum Constants {
        static var title: String { "What's in your fridge?" }
        static var searchPlaceholder: String { "Lemon, Cheese, Sausages..." }
        static var subtitle: String { "Your ingredients" }
        static var addButton: String { "Add" }
        static var searchButton: String { "Search for recipes" }
        static var clearButton: String { "Clear" }
    }
}
