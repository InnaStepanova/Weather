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
        
        tabBar.tintColor = .black
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .white
//        tabBar.layer.cornerRadius = 30
//        tabBar.layer.borderWidth = 1
//        tabBar.layer.masksToBounds = true
        
        let locationWeatherViewController = ViewController()
        let searchWeatherViewController = SearchWeatherViewController()
//
//        let overviewNavigation = NavBarController(rootViewController: overviewController)
//        let sessionNavigation = NavBarController(rootViewController: sessionController)
//        
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
