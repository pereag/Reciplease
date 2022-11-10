//
//  RecipeListRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 09/11/2022.
//

import Foundation
import CoreData

class RecipeListRepository: RecipeListRepositoryType {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func getRecipes() -> [Recipe] {
        var recipes: [Recipe] = []
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        do {
            let objects = try stack.context.fetch(request)
            for object in objects {
                let ingredientLines = object.ingredientLines
                let ingredientLinesArray = ingredientLines!.components(separatedBy: ", ")
                recipes.append(Recipe(name: object.name!, image: object.image!, url: object.url!, source: "string", caution: ["string"], ingredientLines: ingredientLinesArray, totalTime: object.duration))
            }
        } catch {
            print(error)
        }
        
        return recipes
    }
}

protocol RecipeListRepositoryType {
    func getRecipes() -> [Recipe]
}
