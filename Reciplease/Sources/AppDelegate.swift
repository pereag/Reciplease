//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Valc0d3 on 18/07/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coordinator = AppCoordinator(appDelegate: self)
        coordinator.start()
        return true
    }
}
 
