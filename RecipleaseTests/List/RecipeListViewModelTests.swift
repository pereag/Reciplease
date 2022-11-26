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
    
    func testViewDidLoadIfRecipesListIsNotEmptyOrLocalyFetchedIsNoTrue() {
        let recipeList: [Recipe] = [.mock]
        let mockDelegate = MockDelegate()
        let mockRepository = MockRepository()
        viewModel = RecipeListViewModel(recipesList: recipeList,  repository: mockRepository, delegate: mockDelegate)
        viewModel.viewDidLoad()
        viewModel.didPressItem(at: 0)
        XCTAssertNotNil(mockDelegate.presentedRecipe)
        XCTAssertEqual(mockDelegate.presentedRecipe, .mock)
    }
    
    func testThatOnDidPressDetailsButtonCellViewIfIndexNotExist() {
        let recipeList: [Recipe] = [.mock]
        let mockDelegate = MockDelegate()
        viewModel = RecipeListViewModel(recipesList: recipeList, delegate: mockDelegate)
        
        viewModel.viewDidLoad()
        viewModel.didPressItem(at: 1)
        
        XCTAssertNil(mockDelegate.presentedRecipe)
    }
    
    func testViewDidLoadIfRecipesListIsEmpty() {
        let expectation = self.expectation(description: "Display an error")
        let recipeList: [Recipe] = []
        let mockDelegate = MockDelegate()
        let mockRepository = MockRepositoryWithZeroValue()
        viewModel = RecipeListViewModel(recipesList: recipeList,  repository: mockRepository, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "No recipe found.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0)
    }
    
    func testViewDidLoadIfRepositoryIsNil() {
        let expectation = self.expectation(description: "not display an error")
        let recipeList: [Recipe] = []
        let mockDelegate = MockDelegate()
        viewModel = RecipeListViewModel(recipesList: recipeList,  repository: nil, delegate: mockDelegate)
        
        // var counter = 0
        
        /* viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "No recipe found.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        } */
        
        viewModel.viewDidLoad()
        //waitForExpectations(timeout: 1.0)
    }
}

private final class MockDelegate: RecipeViewControllerDelegate {
    var presentedRecipe: Recipe? = nil
    
    func shouldPresent(recipe: Reciplease.Recipe) {
        presentedRecipe = recipe
    }
}

private final class MockRepository: RecipeListRepositoryType {
    func getRecipes() -> [Reciplease.Recipe] {
        return [.mock]
    }
}

private final class MockRepositoryWithZeroValue: RecipeListRepositoryType {
    func getRecipes() -> [Reciplease.Recipe] {
        return []
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
