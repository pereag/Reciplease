//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeViewModel {
    // MARK: Private properties
    
    var recipesList: [RecipeResponse.Hit]
    
    init(recipesList: [RecipeResponse.Hit]) {
        self.recipesList = recipesList
    }
    
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        items?(recipesList)
    }
    
    // MARK: - Outputs
    
    var items: (([RecipeResponse.Hit]) -> Void)?
    var itemsCount:((Int) -> Void)?
    
    // MARK: - Inputs
}
