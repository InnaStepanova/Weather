//
//  CustomTabBarController.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import UIKit

enum Tabs: Int {
    case location
    case search
}

final class CustomTabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configure()
    }
    
    private func configure() {
        
        tabBar.tintColor = UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        tabBar.barTintColor = .white
        tabBar.backgroundColor = UIColor(red: 80.0/255.0, green: 78.0/255.0, blue: 131.0/255.0, alpha: 1.0)

        
        let locationWeatherViewController = LocationWeatherModuleFactory().make()
        let searchWeatherViewController = UINavigationController(rootViewController: SearchWeatherScreenFactory().make())
        
      
        locationWeatherViewController.tabBarItem = UITabBarItem(
            title: "Location",
            image: UIImage(systemName: "location"),
            tag: Tabs.location.rawValue)
        
        searchWeatherViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "location.magnifyingglass"),
            tag: Tabs.search.rawValue)
        
        setViewControllers([locationWeatherViewController, searchWeatherViewController], animated: false)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
