//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeViewModel {
    // MARK: Private properties
    
    let recipesCount: Int
    let recipesList: [RecipeResponse.Hit]
    
    init(recipesCount: Int, recipesList: [RecipeResponse.Hit]) {
        self.recipesCount = recipesCount
        self.recipesList = recipesList
    }
    
    func printRepices() {
        print(self.recipesCount)
        print(self.recipesList)
    }
    
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        printRepices()
    }
    
    // MARK: - Outputs
    
    // MARK: - Inputs
}
