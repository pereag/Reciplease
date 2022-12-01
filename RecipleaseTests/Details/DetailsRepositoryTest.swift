//
//  DetailsRepositoryTest.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 29/11/2022.
//

import XCTest
import CoreData
@testable import Reciplease

final class DetailsRepositoryTest: XCTestCase {
    func testThatCheckIfIsFavoriteReturnTrue() {
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        addMockRecipe(in: stack)
        let repository = DetailsRepository(stack: stack)
        
        let checkIsIsFavorite = repository.checkIfIsFavorite(url: "www.google.com")
        
        XCTAssertTrue(checkIsIsFavorite)
    }
    
    func testThatCheckIfIsFavoriteReturnFalse() {
        // Look with Bertrand
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        let repository = DetailsRepository(stack: stack)
        
        let checkIsIsFavorite = repository.checkIfIsFavorite(url: "www.google.com")
        
        XCTAssertFalse(checkIsIsFavorite)
    }
    
    func testThatAddToFavorites() {
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        let repository = DetailsRepository(stack: stack)
        repository.addToFavorites(recipe: Recipe(
            name: "test",
            image: "https://truck.png",
            url: "www.google.com",
            source: "test",
            caution: ["test"],
            ingredientLines: ["test", "toto"],
            totalTime: 1.0
        ))
    
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let objects = try? stack.context.fetch(request)

        XCTAssertEqual(objects?.count, 1)
    }
    
    func testThatremoveFromFavorites() {
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        let repository = DetailsRepository(stack: stack)
        repository.addToFavorites(recipe: Recipe(
            name: "test",
            image: "https://truck.png",
            url: "www.google.com",
            source: "test",
            caution: ["test"],
            ingredientLines: ["test", "toto"],
            totalTime: 1.0
        ))
        repository.removeFromFavorites(url: "www.google.com")
        
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let objects = try? stack.context.fetch(request)
        
        XCTAssertTrue(objects!.isEmpty)
        XCTAssertEqual(objects?.count, 0)
    }
    
    private func addMockRecipe(in stack: CoreDataStack) {
        let recipe = Recipe(
            name: "test",
            image: "https://truck.png",
            url: "www.google.com",
            source: "test",
            caution: ["test"],
            ingredientLines: ["test", "toto"],
            totalTime: 1.0
        )
        let recipeObject = RecipeEntity(context: stack.context)
        recipeObject.name = recipe.name
        recipeObject.image = recipe.image
        recipeObject.url = recipe.url
        recipeObject.ingredientLines = recipe.ingredientLines.joined(separator: ", ")
        recipeObject.duration = recipe.totalTime
        stack.saveContext()
    }
}

