//
//  RecipeViewModelTests.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 03/10/2022.
//

import XCTest
@testable import Reciplease

final class RecipeListViewModelTests: XCTestCase {
    
    private var viewModel: RecipeListViewModel!
    
    func testThatOnDidPressDetailsButtonCellViewIfIndexExist() {
        let recipeList: [Recipe] = [.mock]
        let mockDelegate = MockDelegate()

        viewModel = RecipeListViewModel(recipesList: recipeList, delegate: mockDelegate)
        viewModel.didPressItem(at: 0)

        XCTAssertNotNil(mockDelegate.presentedRecipe)
        XCTAssertEqual(mockDelegate.presentedRecipe, .mock)
    }
    
    func testThatOnDidPressDetailsButtonCellViewIfIndexNotExist() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(recipesList: [recipe])
        viewModel.didPressItem(at: 1)
    }
    
    
    func testThatOnViewDidLoadIfIsFavoritIsTrue() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(recipesList: [recipe])
        viewModel.viewDidLoad()
    }
    
    func testThatOnViewDidLoadIfIsFavoritIsFalse() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(recipesList: [recipe])
        viewModel.viewDidLoad()
    }
    
    func testThatOnViewDidLoadIfIsFavoritIsTrueWhenZeroRecipeIsAddedOnFavorites() {
        viewModel = RecipeListViewModel(recipesList: [])
        viewModel.viewDidLoad()
    }
}

private final class MockDelegate: RecipeViewControllerDelegate {
    var presentedRecipe: Recipe? = nil

    func shouldPresent(recipe: Reciplease.Recipe) {
        presentedRecipe = recipe
    }
}

private extension Recipe {
    static var mock: Recipe {
        .init(
            name: "yolo",
            image: "image",
            url: "htts",
            source: "rgrgg",
            caution: ["string"],
            ingredientLines: ["string"],
            totalTime: 2.0
        )
    }
}
