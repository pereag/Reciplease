//
//  FavoritesCoordinator.swift
//  Reciplease
//
//  Created by Valc0d3 on 09/11/2022.
//

import UIKit

final class FavoritesCoordinator {

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
        showRecipesListScreen()
    }

    private func showRecipesListScreen() {
        DispatchQueue.main.async {
            let viewController = self.screens.createFavoriteRecipesListViewController(delegate: self)
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

extension FavoritesCoordinator: RecipeViewControllerDelegate {
    func shouldPresent(recipe: Recipe) {
        showDetailsScreen(recipe: recipe)
    }
}
