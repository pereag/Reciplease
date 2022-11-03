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
    private var ingredients: [String] = [] {
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
    var displayedAlert: ((AlertContent) -> Void)?
    var items: (([String]) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        titleText?(Constants.title)
        searchPlaceholderText?(Constants.searchPlaceholder)
        subtitleText?(Constants.subtitle)
        addButtonText?(Constants.addButton)
        clearButtonText?(Constants.clearButton)
        searchButtontext?(Constants.searchButton)
        print("yolo")
    }

    func didPressSearch() {
        if ingredients.count == 0 {
            let alertContent = AlertContent(
               title: "Alert",
               message: "Please add Foods.",
               cancelTitle: "Ok"
            )
            self.displayedAlert?(alertContent)
            return
        }
        repository.getRecipe(for: ingredients, callback: { [weak self] result in
            switch result {
            case let .success(response):
                if response.hits.count == 0 {
                    let alertContent = AlertContent(
                       title: "Alert",
                       message: "No result.",
                       cancelTitle: "Ok"
                    )
                    self?.displayedAlert?(alertContent)
                    return
                }

                let recipes: [Recipe] = response.hits.map { hit in
                    return Recipe(hit: hit)
                }
               
                self?.delegate?.shouldPresent(recipes: recipes)
            case let .failure(error):
                let alertContent = AlertContent(
                   title: "Alert",
                   message: "An unexpected error has occurred.",
                   cancelTitle: "Ok"
                )
                self?.displayedAlert?(alertContent)
                print(error.localizedDescription)
            }
        })
    }
    
    func didPressAdd(item: String) {
        if item.isEmpty {
            let alertContent = AlertContent(
               title: "Alert",
               message: "Please fill in the field.",
               cancelTitle: "Ok"
            )
            self.displayedAlert?(alertContent)
        } else {
            if !ingredients.contains(item.lowercased()) {
                ingredients.append(item.lowercased())
            } else {
                let alertContent = AlertContent(
                   title: "Alert",
                   message: "Food already present in the list.",
                   cancelTitle: "Ok"
                )
                self.displayedAlert?(alertContent)
            }
        }
    }
    
    func didPressClear() {
        if ingredients.count <= 0 {
            let alertContent = AlertContent(
               title: "Alert",
               message: "No foods in the list to delete.",
               cancelTitle: "Ok"
            )
            self.displayedAlert?(alertContent)
        } else {
            ingredients.removeAll()
        }
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
