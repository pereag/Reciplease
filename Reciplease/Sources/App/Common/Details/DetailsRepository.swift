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
    
    func checkIfIsFavorite(url: String) throws -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecipeEntity.url, ascending: true)]
        
        let result = try stack.context.fetch(request)
        return !result.isEmpty
    }
    
    func addToFavorites(recipe: Recipe) {
        let recipeObject = RecipeEntity(context: stack.context)
        recipeObject.name = recipe.name
        recipeObject.image = recipe.image
        recipeObject.url = recipe.url
        recipeObject.ingredientLines = recipe.ingredientLines.joined(separator: ", ")
        recipeObject.duration = recipe.totalTime
        stack.saveContext()        
    }
    
    func removeFromFavorites(url: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            let object = try stack.context.fetch(request)
            if !object.isEmpty {
                stack.context.delete(object[0])
                stack.saveContext()
            }
        } catch {
            print(error)
        }
    }
}

protocol DetailsRepositoryType {
    func checkIfIsFavorite(url: String) throws -> Bool
    func addToFavorites(recipe: Recipe)
    func removeFromFavorites(url: String)
}
