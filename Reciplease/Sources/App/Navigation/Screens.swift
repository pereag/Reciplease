//
//  Screens.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

public class Screens {
    
    // MARK: - Properties
    
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
    
    let context: Context
    
    init(context: Context) {
        self.context = context
    }
}

// MARK: - Home

protocol SearchViewControllerDelegate: AnyObject {
    func shouldPresent(recipes: [Recipe])
}

protocol RecipeViewControllerDelegate: AnyObject {
    func shouldPresent(recipe: Recipe)
}

extension Screens {
    func createSearchViewController(delegate: SearchViewControllerDelegate) -> UIViewController {
        let repository = SearchRepository(client: context.client)
        let viewModel = SearchViewModel(
            repository: repository,
            delegate: delegate
        )
        let viewController = storyBoard.instantiateViewController(
            withIdentifier: "SearchViewController"
        ) as! SearchViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createRecipeListViewController(recipes: [Recipe], delegate: RecipeViewControllerDelegate) -> UIViewController {
        let viewModel = RecipeListViewModel(
            recipesList: recipes,
            delegate: delegate
        )
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createDetailsViewController(recipe: Recipe) -> UIViewController {
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let repository = DetailsRepository(stack: context.stack)
        let viewModel = DetailsViewModel(
            recipe: recipe,
            repository: repository as DetailsRepositoryType
        )
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createFavoriteRecipesListViewController(delegate: RecipeViewControllerDelegate) -> UIViewController {
        let repository = RecipeListRepository(stack: context.stack)
        let viewModel = RecipeListViewModel(
            recipesList: [],
            repository: repository,
            delegate: delegate
        )
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeListViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
