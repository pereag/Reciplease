//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class SearchCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController
    private let screens: Screens
    
    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coodinator

    func start() {
        showSearchScreen()
    }

    private func showSearchScreen() {
        let viewController = screens.createSearchViewController(
            delegate: self
        )
        presenter.viewControllers = [viewController]
    }

    private func showResultScreen(recipes: [Recipe]) {
        DispatchQueue.main.async {
            let viewController = self.screens.createResultViewController(recipes: recipes, delegate: self)
            self.presenter.pushViewController(viewController, animated: true)
        }
    }
    
    private func showDetailsScreen(recipe: Recipe) {
        DispatchQueue.main.async {
            let viewController = self.screens.createDetailsViewController(recipe: recipe)
            self.presenter.pushViewController(viewController, animated: true)
        }
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func shouldPresent(recipes: [Recipe]) {
        showResultScreen(recipes: recipes)
    }
}

extension SearchCoordinator: RecipeViewControllerDelegate {
    func shouldPresent(recipe: Recipe) {
        showDetailsScreen(recipe: recipe)
    }
}
