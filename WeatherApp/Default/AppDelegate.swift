//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        createAndShowStartVC()
        
        return true
    }
}

// MARK: - Initial application settings

private extension AppDelegate {
    func createAndShowStartVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CustomTabBarController()
        window?.makeKeyAndVisible()
    }
}

