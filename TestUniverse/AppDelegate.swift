//
//  AppDelegate.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = Coordinator(navigationController: NavigationVC())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
                
        
        
        coordinator?.showOnboarding()
        return true
    }

    


}

