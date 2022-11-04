//
//  DetailsViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 03/10/2022.
//

import Foundation

class DetailsViewModel {
    
    // MARK: Properties
    
    var recipe: Recipe
    private let repository: DetailsRepositoryType
    private var isFavorite = false
    
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
        ingredientsTitle?(Constants.ingredientsTitle)
        buttonLabel?(Constants.getDirectionTitle)
        currentRecipe?(recipe)
        heartsState?(isFavorite)
        print(isFavorite)
    }
    
    func didPressFavorite() -> Bool {
        if isFavorite {
            repository.removeFromFavorites()
        } else {
            repository.addToFavorites()
        }
        isFavorite.toggle()
        return isFavorite
    }
}

private extension DetailsViewModel {
    enum Constants {
        static var ingredientsTitle: String { "Your ingredients :"}
        static var getDirectionTitle: String { "Get directions" }
    }
}
