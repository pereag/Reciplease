//
//  Recipe.swift
//  Reciplease
//
//  Created by Valc0d3 on 03/10/2022.
//

import Foundation

struct Recipe: Equatable {
    let name: String
    let image: String
    let url : String
    let source: String
    let caution, ingredientLines: [String]
    let totalTime: Double
}

extension Recipe {
    init(hit: RecipeResponse.Hit) {
        self.name = hit.recipe.label
        self.image = hit.recipe.image
        self.url = hit.recipe.url
        self.source = hit.recipe.source
        self.caution = hit.recipe.cautions
        self.ingredientLines = hit.recipe.ingredientLines
        self.totalTime = hit.recipe.totalTime
    }
}
