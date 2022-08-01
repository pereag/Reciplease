//
//  AppCoordinator.swift
//  Reciplease
//
//  Created by Valc0d3 on 01/08/2022.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Private properties

    private unowned var appDelegate: AppDelegate
    private var homeCoordinator: HomeCoordinator?

    // MARK: - Initializer

    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }

    // MARK: - Coordinator

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.makeKeyAndVisible()

        showHome()
    }

    private func showHome() {
        homeCoordinator = HomeCoordinator(presenter: appDelegate.window!)
        homeCoordinator?.start()
    }
}
