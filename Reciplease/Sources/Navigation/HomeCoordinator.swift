//
//  HomeCoordinator.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

enum ViewControllerItem: Int {
    case search = 0
    case favorites = 1
}

protocol TabBarSourceType {
    var items: [UINavigationController] { get set }
}


extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
}

fileprivate class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]

    init() {
        self[.search].tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        self[.favorites].tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
}

final class HomeCoordinator: NSObject, UITabBarControllerDelegate {

    // MARK: - Properties
    
    private let presenter: UIWindow
    private let tabBarController: UITabBarController
    private let screens: Screens
    private var tabBarSource: TabBarSourceType = TabBarSource()

    // MARK: - Flows
    private var searchCoordinator: SearchCoordinator?

    // MARK: - Init

    init(presenter: UIWindow) {
        self.presenter = presenter
        screens = Screens()
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = tabBarSource.items
        tabBarController.selectedViewController = tabBarSource[.search]

        super.init()

        tabBarController.delegate = self
        self.presenter.rootViewController = tabBarController
    }

    // MARK: - Coordinator

    func start() {
        showSearch()
    }

    private func showSearch() {
        searchCoordinator = SearchCoordinator(presenter: tabBarSource[.search], screens: screens)
        searchCoordinator?.start()
    }

    private func showFavorites() {
        // TODO: - To implement later
    }
}

extension HomeCoordinator {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < tabBarSource.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Selected ViewController Index Out Of range")
        }

        switch item {
        case .search:
            showSearch()
        case .favorites:
            showFavorites()
        }
    }
}


