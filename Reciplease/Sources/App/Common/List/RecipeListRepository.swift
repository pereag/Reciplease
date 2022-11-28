//
//  RecipeListRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 09/11/2022.
//

import Foundation
import CoreData

class RecipeListRepository: RecipeListRepositoryType {
    
    // MARK: Properties
    
    private let stack: CoreDataStack
    
    // MARK: Init
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func getRecipes() -> [Recipe] {
        var recipes: [Recipe] = []
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let objects = try? stack.context.fetch(request)
        guard let objects else { return [] }
        for object in objects {
            let ingredientLines = object.ingredientLines
            let ingredientLinesArray = ingredientLines!.components(separatedBy: ", ")
            recipes.append(Recipe(name: object.name!, image: object.image!, url: object.url!, source: "string", caution: ["string"], ingredientLines: ingredientLinesArray, totalTime: object.duration))
        }
        
        return recipes
    }
}

protocol RecipeListRepositoryType {
    func getRecipes() -> [Recipe]
}
