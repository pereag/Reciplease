//
//  DetailsViewModelTests.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 07/11/2022.
//

import XCTest
@testable import Reciplease

final class DetailsViewModelTests: XCTestCase {
    
    private var viewModel: DetailsViewModel!
    private var repository: DetailsRepository!
    private let recipe: Recipe = Recipe(name: "test", image: "test", url: "test", source: "test", caution: ["test"], ingredientLines: ["test"], totalTime: 2.0)
    
    func testThatOnViewDidLoad_ThenEveryhtingIsCorrectlyLoaded() {
        let expectation1 = self.expectation(description: "Returned ingredients title")
        let expectation2 = self.expectation(description: "Returned get direction button title")
        let recipe: Recipe = Recipe(name: "test", image: "test", url: "test", source: "test", caution: ["test"], ingredientLines: ["test"], totalTime: 2.0)
        viewModel = DetailsViewModel(recipe: recipe, repository: MockRepositoryCheckFavoriteReturnFalse())
        
        viewModel.ingredientsTitle = { text in
            XCTAssertEqual(text, "Your ingredients :")
            expectation1.fulfill()
        }
        
        viewModel.buttonLabel = { text in
            XCTAssertEqual(text, "Get directions")
            expectation2.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testThatOnDidPressdidPressFavoriteWhenItReturnTrue() {
        let recipe: Recipe = self.recipe
        viewModel = DetailsViewModel(recipe: recipe, repository: MockRepositoryCheckFavoriteReturnFalse())
        viewModel.viewDidLoad()
        XCTAssertTrue(viewModel.didPressFavorite())
    }
    
    func testThatOnDidPressdidPressFavoriteWhenItReturnFalse() {
        let recipe: Recipe = self.recipe
        viewModel = DetailsViewModel(recipe: recipe, repository: MockRepositoryCheckFavoriteReturnTrue())
        viewModel.viewDidLoad()
        XCTAssertTrue(!viewModel.didPressFavorite())
    }
}


private final class MockRepositoryCheckFavoriteReturnTrue: DetailsRepositoryType {
    func checkIfIsFavorite(url: String) -> Bool {
        return true
    }
    
    func addToFavorites(recipe: Reciplease.Recipe) {
        return
    }
    
    func removeFromFavorites(url: String) {
        return
    }
}

private final class MockRepositoryCheckFavoriteReturnFalse: DetailsRepositoryType {
    func checkIfIsFavorite(url: String) -> Bool {
        return false
    }
    
    func addToFavorites(recipe: Reciplease.Recipe) {
        return
    }
    
    func removeFromFavorites(url: String) {
        return
    }
}

