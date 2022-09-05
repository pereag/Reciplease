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
        repository.onGetRecipe = .success(.init(name: "Toto"))
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
        
        viewModel.subtitleText = { text in
            XCTAssertEqual(text, "Your ingredients")
        }
        
        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "Add")
        }
        
        viewModel.searchButtontext = { text in
            XCTAssertEqual(text, "Search for recipes")
        }
        
        viewModel.clearButtonText = { text in
            XCTAssertEqual(text, "Clear")
        }

        viewModel.items = { items in
            XCTAssertTrue(items.isEmpty)
            expectation3.fulfill()
        }

        viewModel.viewDidLoad()
    
        waitForExpectations(timeout: 1.0)
    }

    func testThatOnDidPressSearch_WithSuccess_ThenDelegateIsReturned() {
        repository.onGetRecipe = .success(.init(name: "Toto"))
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )

        viewModel.didPressSearch()

        XCTAssertTrue(delegate._didPressSearch)
    }
    
    func testThatOnDidPressAdd_WithSuccess_IngredientsAppendItem() {
        let expectation = self.expectation(description: "Item is added")
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )
        
        viewModel.items = { items in
            XCTAssertEqual(items[0], "banana")
            expectation.fulfill()
        }

        viewModel.didPressAdd(item: "Banana")
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testThatOnDidPressAdd_WithFaillure_IngredientsAppendItem() {
        let expectation = self.expectation(description: "Item can't be added twice")
        expectation.expectedFulfillmentCount = 1
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )
        
        viewModel.items = { items in
            XCTAssertEqual(items.count, 1)
            expectation.fulfill()
        }

        viewModel.didPressAdd(item: "Banana")
        viewModel.didPressAdd(item: "banana")
        viewModel.didPressAdd(item: "BaNana")
        viewModel.didPressAdd(item: "bananA")
        viewModel.didPressAdd(item: "Banana")
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testThatOnDidPressClear_WithSuccess_AllIngredientsItemsIsRemove() {
        let expectation = self.expectation(description: "Items can be empty")
        expectation.expectedFulfillmentCount = 2
        viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )

        var counter = 0
        viewModel.items = { items in
            if counter == 1 {
                XCTAssertTrue(items.isEmpty)
            }
            counter+=1
            expectation.fulfill()
        }

        viewModel.didPressAdd(item: "Banana")
        viewModel.didPressClear()
        
        waitForExpectations(timeout: 1.0)
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
