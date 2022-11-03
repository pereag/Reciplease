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
    private var favorit: Bool = false
    
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
    }

    private var isFavorite = false {
        didSet {
            heartsState?(isFavorite)
        }
    }
    
    func didPressStar() {
        if isFavorite {
            repository.removeFromFavorites()
        } else {
            repository.addToFavorites()
        }
    
        isFavorite.toggle()
    }
}

private extension DetailsViewModel {
    enum Constants {
        static var ingredientsTitle: String { "Your ingredients :" }
        static var getDirectionTitle: String { "Get directions" }
    }
}
