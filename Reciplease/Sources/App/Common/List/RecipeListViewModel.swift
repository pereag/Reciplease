//
//  RecipeViewModel.swift
//  Reciplease
//
//  Created by Valc0d3 on 26/09/2022.
//

import Foundation

final class RecipeListViewModel {
    
    // MARK: Private properties
    
    private var recipesList: [Recipe]
    private let repository: RecipeListRepositoryType?
    private weak var delegate: RecipeViewControllerDelegate?
    private var localyFetched = false
    
    // MARK: - Init
    
    init(
        recipesList: [Recipe],
        repository: RecipeListRepositoryType? = nil,
        delegate: RecipeViewControllerDelegate? = nil
    ) {
        self.recipesList = recipesList
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs
    
    var items: (([Recipe]) -> Void)?
    var displayedAlert: ((AlertContent) -> Void)?
    
    // MARK: - Inputs
    
    func didPressItem(at index: Int) {
        guard recipesList.indices.contains(index) else { return }
        delegate?.shouldPresent(recipe: recipesList[index])
    }
    
    // MARK: Cycle Life
    
    func viewDidLoad() {
        if recipesList.isEmpty || localyFetched {
            guard let result = repository?.getRecipes() else { return }
            if result.count == 0 {
                let alertContent = AlertContent(title: "Alert", message: "No recipe found.", cancelTitle: "Ok")
                self.displayedAlert?(alertContent)
            }
            recipesList = result
            items?(recipesList)
            localyFetched = true
        } else {
            items?(recipesList)
        }
    }
}
