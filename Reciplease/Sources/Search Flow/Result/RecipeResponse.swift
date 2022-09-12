//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Valc0d3 on 05/09/2022.
//

import Foundation

// MARK: - RecipeResponse
struct RecipeResponse: Codable {
    let from, to, count: Int
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case hits
    }
    
    // MARK: - Hit
    struct Hit: Codable {
        let recipe: Recipe

        enum CodingKeys: String, CodingKey {
            case recipe
        }
        
        // MARK: - Recipe
        struct Recipe: Codable {
            let uri: String
            let label: String
            let image: String
            let images: Images
            let ingredients: [Ingredient]
            
            // MARK: - Images
            struct Images: Codable {
                let thumbnail, small, regular: Large
                let large: Large?

                enum CodingKeys: String, CodingKey {
                    case thumbnail = "THUMBNAIL"
                    case small = "SMALL"
                    case regular = "REGULAR"
                    case large = "LARGE"
                }
                
                // MARK: - Large
                struct Large: Codable {
                    let url: String
                    let width, height: Int
                }
            }

            // MARK: - Ingredient
            struct Ingredient: Codable {
                let text: String
                let quantity: Double
                let measure: String?
                let food: String
                let weight: Double
                let foodCategory, foodID: String
                let image: String

                enum CodingKeys: String, CodingKey {
                    case text, quantity, measure, food, weight, foodCategory
                    case foodID = "foodId"
                    case image
                }
            }
        }
    }
}
