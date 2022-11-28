//
//  RecipeListRepositoryTests.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 28/11/2022.
//

import Foundation
import XCTest
@testable import Reciplease

final class RecipeListRepositoryTests : XCTestCase {

    func testThatGetRecipesReturnRecipes() {
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        addMockRecipe(in: stack)
        let repository = RecipeListRepository(stack: stack)
        
        let result = repository.getRecipes()

        XCTAssertEqual(result.count, 1)
    }

    func testThatGetRecipesReturnEmptyArray() {
        let stack = CoreDataStack(modelName: "Reciplease", type: .test)
        let repository = RecipeListRepository(stack: stack)
        
        let result = repository.getRecipes()

        XCTAssertEqual(result.count, 0)
    }

    private func addMockRecipe(in stack: CoreDataStack) {
        let recipe = Recipe(
            name: "",
            image: "",
            url: "",
            source: "",
            caution: [],
            ingredientLines: [],
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
