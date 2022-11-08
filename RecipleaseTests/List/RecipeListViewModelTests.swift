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
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(isFavorite: false, recipesList: [recipe])
         viewModel.didPressDetailsButtonCellView(index: 0)
     }
    
    func testThatOnDidPressDetailsButtonCellViewIfIndexNotExist() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(isFavorite: false, recipesList: [recipe])
         viewModel.didPressDetailsButtonCellView(index: 1)
     }
    
    
    func testThatOnViewDidLoadIfIsFavoritIsTrue() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(isFavorite: true, recipesList: [recipe])
         viewModel.viewDidLoad()
     }
    
    func testThatOnViewDidLoadIfIsFavoritIsFalse() {
        let recipe: Recipe = Recipe(name: "yolo", image: "image", url: "htts", source: "rgrgg", caution: ["string"], ingredientLines: ["string"], totalTime: 2.0)
        viewModel = RecipeListViewModel(isFavorite: false, recipesList: [recipe])
        viewModel.viewDidLoad()
     }
    
}
 
