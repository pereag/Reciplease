//
//  SearchViewModelTests.swift
//  RecipleaseTests
//
//  Created by Valc0d3 on 08/08/2022.
//

import XCTest
@testable import Reciplease

final class SearchViewModelTests: XCTestCase {

    private var repository: MockRepository!
    private var delegate: MockDelegate!
    private var viewModel: SearchViewModel!

    override func setUp() {
        super.setUp()
        delegate = MockDelegate()
        repository = MockRepository()
    }
    

    func testThatOnViewDidLoad_ThenEveryhtingIsCorrectlyLoaded() {
        let expectation1 = self.expectation(description: "Returned Title")
        let expectation2 = self.expectation(description: "Returned Search PlaceHolder")
        let expectation3 = self.expectation(description: "Returned Empty Ingredients")
        repository.onGetRecipe = .success(.init())
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )

        viewModel.titleText = { text in
            XCTAssertEqual(text, "What's in your fridge?")
            expectation1.fulfill()
        }

        viewModel.searchPlaceholderText = { text in
            XCTAssertEqual(text, "Lemon, Cheese, Sausages...")
            expectation2.fulfill()
        }

        viewModel.items = { items in
            XCTAssertTrue(items.isEmpty)
            expectation3.fulfill()
        }

        viewModel.viewDidLoad()
    
        waitForExpectations(timeout: 1.0)
    }

    func testThatOnDidPressSearch_WithSuccess_ThenDelegateIsReturned() {
        repository.onGetRecipe = .success(.init())
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )

        viewModel.didPressSearch()

        XCTAssertTrue(delegate._didPressSearch)
    }
}

private final class MockRepository: SearchRepositoryType {
    var onGetRecipe: Result<RecipeResponse, Error>!

    func getRecipe(for ingredients: [String], callback: (Result<RecipeResponse, Error>) -> Void) {
        callback(onGetRecipe)
    }
}

private final class MockDelegate: SearchViewControllerDelegate {
    var _didPressSearch = false
    
    func searchScreenDidSelectDetail(with title: String) {
        
    }
    
    func didPressSearch() {
        _didPressSearch = true
    }
}
