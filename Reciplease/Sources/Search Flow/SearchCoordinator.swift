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
        let viewController = screens.creatSearchViewController(
            delegate: self
        )
        presenter.viewControllers = [viewController]
    }

    private func showResult(recipes: [String]) {
        let viewController = screens.createResultViewController(recipes: recipes)
        DispatchQueue.main.async {
            self.presenter.pushViewController(viewController, animated: true)
        }
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func shouldPresent(recipes: [String]) {
        showResult(recipes: recipes)
    }
}

