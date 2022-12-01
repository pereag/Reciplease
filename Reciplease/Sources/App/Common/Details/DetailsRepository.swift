//
//  DetailsRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 17/10/2022.
//

import Foundation
import CoreData


final class DetailsRepository: DetailsRepositoryType {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }

    enum CustomError: Error {
        case toto
    }

    func checkIfIsFavorite(url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \RecipeEntity.url,
                ascending: true
            )
        ]

        var result: [RecipeEntity] = []
        
        do {
            result = try stack.context.fetch(request)
        } catch {
            assertionFailure(error.localizedDescription)
        }

        return !result.isEmpty
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

        var result: [RecipeEntity] = []

        do {
            result = try stack.context.fetch(request)
        } catch {
            assertionFailure(error.localizedDescription)
        }

        if let object = result.first {
            stack.context.delete(object)
            stack.saveContext()
        }
    }
}

protocol DetailsRepositoryType {
    func checkIfIsFavorite(url: String) -> Bool
    func addToFavorites(recipe: Recipe)
    func removeFromFavorites(url: String)
}
