//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeViewModel {
    // MARK: Private properties
    
    var recipesList: [Recipe]
    
    init(recipesList: [Recipe]) {
        self.recipesList = recipesList
    }
    
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        items?(recipesList)
    }
    
    // MARK: - Outputs
    
    var items: (([Recipe]) -> Void)?
    var itemsCount:((Int) -> Void)?
    
    // MARK: - Inputs
}
