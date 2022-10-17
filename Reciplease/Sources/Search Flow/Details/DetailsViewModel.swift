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
    
    init(recipe: Recipe, repository: DetailsRepositoryType) {
        self.recipe = recipe
        self.repository = repository
    }
    
    // MARK: Outputs
    
    var ingredientsText: ((String) -> Void)?
    var starState: ((Bool) -> Void)?
    
    // MARK: CycleLife
    
    func viewDidLoad() {
        
//        ingredientsText?(recipe.ingredientLines)
        //ingredientsLabel?(ingredientsTitle)
    }

    private var isFavorite = false {
        didSet {
            starState?(isFavorite)
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
