//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeListViewModel {
    
    // MARK: Private properties
    private let isFavorite: Bool
    private var recipesList: [Recipe]
    private let repository: RecipeListRepositoryType?
    private var delegate: RecipeViewControllerDelegate?
    
    init(
        isFavorite: Bool,
        recipesList: [Recipe],
        repository: RecipeListRepositoryType? = nil,
        delegate: RecipeViewControllerDelegate? = nil
    ) {
        self.isFavorite = isFavorite
        self.repository = repository
        self.recipesList = recipesList
        self.delegate = delegate
    }

    // MARK: - Initializer
    
    func viewDidLoad() {
        if isFavorite {
            guard let result = repository?.getRecipes() else { return }
            items?(result)
        } else {
            items?(recipesList)
        }
    }

    // MARK: - Outputs
    
    var items: (([Recipe]) -> Void)?
    
    // MARK: - Inputs
    
    func didPressDetailsButtonCellView(index: Int) {
        guard recipesList.indices.contains(index) else { return }
        delegate?.shouldPresent(recipe: recipesList[index])
    }
}
