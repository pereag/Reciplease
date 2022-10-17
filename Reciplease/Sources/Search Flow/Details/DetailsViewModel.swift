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
    
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // MARK: Outputs
    
    var item: ((Recipe) -> Void)?
    var ingredientsLabel: ((Recipe) -> Void)?
    
    // MARK: CycleLife
    
    func viewDidLoad() {
        item?(recipe)
        //ingredientsLabel?(ingredientsTitle)
    }
}

private extension DetailsViewModel {
    enum Constants {
        static var ingredientsTitle: String { "Your ingredients :" }
        static var getDirectionTitle: String { "Get directions" }
    }
}
