//
//  DetailsRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 17/10/2022.
//

import Foundation
import CoreData


class DetailsRepository: DetailsRepositoryType {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func checkIfIsFavorite(url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecipeEntity.url, ascending: true)]
        
        let result = try? stack.context.fetch(request)
    
        if let result {
            return !result.isEmpty
        }

        return false
    }
    
    func addToFavorites(recipe: Recipe) {
        let recipeObject = RecipeEntity(context: stack.context)
        recipeObject.name = recipe.name
        recipeObject.image = recipe.image
        recipeObject.url = recipe.url
        recipeObject.ingredientLines = recipe.ingredientLines.joined(separator: ", ")
        recipeObject.duration = recipe.totalTime

        if stack.context.hasChanges {
            stack.saveContext()
        }
    }
    
    func removeFromFavorites(url: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        
        let object = try? stack.context.fetch(request)
        guard let object else { return }
        if !object.isEmpty, stack.context.hasChanges {
            stack.context.delete(object[0])
            stack.saveContext()
        }
    }
}

protocol DetailsRepositoryType {
    func checkIfIsFavorite(url: String) -> Bool
    func addToFavorites(recipe: Recipe)
    func removeFromFavorites(url: String)
}
