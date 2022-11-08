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

    func testThatOnViewDidLoad_ThenEveryhtingIsCorrectlyLoaded() {
        let expectation1 = self.expectation(description: "Returned Title")
        let expectation2 = self.expectation(description: "Returned Search PlaceHolder")
        let expectation3 = self.expectation(description: "Returned Empty Ingredients")
        let expectation4 = self.expectation(description: "Returned add button text")
        let expectation5 = self.expectation(description: "Returned searchButton text")
        let expectation6 = self.expectation(description: "Returned clear button text")
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(
            repository: mockResponse,
            delegate: mockDelegate
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
            expectation3.fulfill()
        }
        
        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "Add")
            expectation4.fulfill()
        }
        
        viewModel.searchButtontext = { text in
            XCTAssertEqual(text, "Search for recipes")
            expectation5.fulfill()
        }
        
        viewModel.clearButtonText = { text in
            XCTAssertEqual(text, "Clear")
            expectation6.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0)
    }
    
   func testThatOnDidPressSearch_WithSuccess_ThenDelegateIsReturned() {
        let mockRepository = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
       
        viewModel = SearchViewModel(repository: mockRepository, delegate: mockDelegate)
       
        viewModel.didPressAdd(item: "Banana")
       
        viewModel.didPressSearch()
       
       XCTAssertTrue(!mockDelegate.returnedRecipes.isEmpty)
    }
    
    func testThatOnDidPressAdd_WithSuccess_IngredientsAppendItem() {
        let expectation = self.expectation(description: "Item is added")
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        viewModel.items = { items in
            XCTAssertEqual(items[0], "banana")
            expectation.fulfill()
        }
        
        viewModel.didPressAdd(item: "Banana")
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testThatOnDidPressAdd_WithFailure_IngredientsAppendItem() {
        let expectation = self.expectation(description: "Item can't be added twice")
        expectation.expectedFulfillmentCount = 1
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
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
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
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
    
    func testThatOndidPressAdd_WhithIngrendientsArrayIsEmpty_DisplayAnAlert() {
        let expectation = self.expectation(description: "Display alert")
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "Please add Foods.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        viewModel.viewDidLoad()
        viewModel.didPressSearch()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testThatOndidPressClear_WhithIngrendientsArrayIsEmpty_DisplayAnAlert() {
        let expectation = self.expectation(description: "Display alert")
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "No foods in the list to delete.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        viewModel.viewDidLoad()
        viewModel.didPressClear()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testThatOndidPressAdd_WhithIngredientFieldIsEmpty_DisplayAnAlert() {
        let expectation = self.expectation(description: "Display alert")
        let mockResponse = MockRepository(responses: .success)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "Please fill in the field.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        viewModel.viewDidLoad()
        viewModel.didPressAdd(item: "")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatOnDidPressSearch_withIsFailure_DisplayAnAlert() {
        let expectation = self.expectation(description: "Display alert")
        let mockResponse = MockRepository(responses: .failure)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "Please fill in the field.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        viewModel.viewDidLoad()
        viewModel.didPressAdd(item: "")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatOnDidPressSearch_withFailure_DisplayAnAlert() {
        let expectation = self.expectation(description: "Display alert")
        let mockResponse = MockRepository(responses: .failure)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "An unexpected error has occurred.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter+=1
        }
        viewModel.viewDidLoad()
        viewModel.didPressAdd(item: "fgfgdggfgdfgggrgrg")
        viewModel.didPressSearch()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThanOnDidPressSearchWithSuccessButZeroItemsIsReturned() {
        let expectation = self.expectation(description: "return Alerte error")
        let mockResponse = MockRepository(responses: .successWithZeroItemsReturned)
        let mockDelegate = MockDelegate()
        viewModel = SearchViewModel(repository: mockResponse, delegate: mockDelegate)
        
        var counter  = 0
        
        viewModel.displayedAlert = { alert in
            if counter == 0 {
                XCTAssertEqual(alert.title, "Alert")
                XCTAssertEqual(alert.message, "No result.")
                XCTAssertEqual(alert.cancelTitle, "Ok")
                expectation.fulfill()
            }
            counter = counter + 1
        }
        viewModel.viewDidLoad()
        viewModel.didPressAdd(item: "fgfgdggfgdfgggrgrg")
        viewModel.didPressSearch()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

private final class MockRepository: SearchRepositoryType {
    let responses: Responses
    
    init(responses: Responses) {
        self.responses = responses
    }
    struct Responses {
        var onGetRecipe: Result<RecipeResponse, Error>!
    }
    
    func getRecipe(for ingredients: [String], callback: (Result<RecipeResponse, Error>) -> Void) {
        callback(responses.onGetRecipe)
    }
}

private final class MockDelegate: SearchViewControllerDelegate {
    var returnedRecipes: [Recipe] = []
    
    func shouldPresent(recipes: [Recipe]) {
        returnedRecipes = recipes
    }
}

private extension MockRepository.Responses {
    static var success: MockRepository.Responses {
        return .init(
            onGetRecipe: .success(mockRecipeResponse)
        )
    }
    
    static var successWithZeroItemsReturned: MockRepository.Responses {
        return .init(
            onGetRecipe: .success(mockRecipeResponseWithZeroItemsReturned)
        )
    }
    
    static var failure: MockRepository.Responses {
        return .init(
            onGetRecipe: .failure(MockError.mock)
        )
    }
    
    enum MockError: Error {
        case mock
    }

    static let mockRecipeResponse = try! JSONDecoder().decode(RecipeResponse.self, from: MockData.recipeData)
    static let mockRecipeResponseWithZeroItemsReturned = try! JSONDecoder().decode(RecipeResponse.self, from: MockData.recipeDataWithZeroResult)
}






