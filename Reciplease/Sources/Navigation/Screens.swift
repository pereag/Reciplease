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

    func createResultViewController(recipes: [Recipe], delegate: RecipeViewControllerDelegate) -> UIViewController {
        let viewModel = RecipeViewModel(
            recipesList: recipes,
            delegate: delegate
        )
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createDetailsViewController(recipe: Recipe) -> UIViewController {
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let viewModel = DetailsViewModel(
            recipe: recipe
        )
        viewController.viewModel = viewModel
        return viewController
    }
}
