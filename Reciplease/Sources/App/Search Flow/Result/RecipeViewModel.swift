//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeViewModel {
    
    // MARK: Private properties
    private var recipesList: [Recipe]
    private var delegate: RecipeViewControllerDelegate?
    
    
    init(recipesList: [Recipe], delegate: RecipeViewControllerDelegate) {
        self.recipesList = recipesList
        self.delegate = delegate
    }
    
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        items?(recipesList)
    }
    
    // MARK: - Outputs
    
    var items: (([Recipe]) -> Void)?
    
    // MARK: - Inputs
    
    func didPressDetailsButtonCellView(index: Int) {
        guard recipesList.indices.contains(index) else { return }
        delegate?.shouldPresent(recipe: recipesList[index])
    }
}
