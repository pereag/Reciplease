//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Valc0d3 on 05/09/2022.
//

import Foundation

// MARK: - RecipeResponse

struct RecipeResponse: Codable, Equatable {
    
    let from, to: Int
    let hits: [Hit]
    
    // MARK: - Hit
    struct Hit: Codable, Equatable {
        
        let recipe: Recipe

        // MARK: - Recipe
        struct Recipe: Codable, Equatable {
            let label: String
            let image: String
            let yield: Double
            let source: String
            let url: String
            let shareAs: String
            let cautions, ingredientLines: [String]
        }
    }
}
