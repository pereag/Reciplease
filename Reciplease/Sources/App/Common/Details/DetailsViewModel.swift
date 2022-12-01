//
//  DetailsViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 03/10/2022.
//

import Foundation

final class DetailsViewModel {
    
    // MARK: Properties
    
    var recipe: Recipe
    private let repository: DetailsRepositoryType
    private var isFavorite = false {
        didSet {
            heartsState?(isFavorite)
        }
    }
    
    init(recipe: Recipe, repository: DetailsRepositoryType) {
        self.recipe = recipe
        self.repository = repository
    }
    
    // MARK: Outputs
    
    var ingredientsTitle: ((String) -> Void)?
    var buttonLabel: ((String) -> Void)?
    var heartsState: ((Bool) -> Void)?
    var currentRecipe: ((Recipe) -> Void)?
    
    // MARK: CycleLife
    
    func viewDidLoad() {
        checkIfRecipeIsInFavorite()
        ingredientsTitle?(Constants.ingredientsTitle)
        buttonLabel?(Constants.getDirectionTitle)
        currentRecipe?(recipe)
    }
    
    func didPressFavorite() -> Bool {
        if isFavorite {
            repository.removeFromFavorites(url: recipe.url)
        } else {
            repository.addToFavorites(recipe: recipe)
        }
        isFavorite.toggle()
        return isFavorite
    }
    
    func checkIfRecipeIsInFavorite() {
        isFavorite = repository.checkIfIsFavorite(url: recipe.url)
    }
}

private extension DetailsViewModel {
    enum Constants {
        static var ingredientsTitle: String { "Your ingredients :"}
        static var getDirectionTitle: String { "Get directions" }
    }
}
