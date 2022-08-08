//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Valc0d3 on 18/07/2022.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AppCoordinator!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = AppCoordinator(appDelegate: self)
        coordinator.start()
        return true
    } 
}
 
