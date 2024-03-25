//
//  SearchWeatherScreenRouter.swift
//  WeatherApp
//
//  Created by Лаванда on 25.03.2024.
//

import UIKit

protocol SearchWeatherScreenRouterProtocol: AnyObject {
    func setRootViewController(root: UIViewController)
    func openCityWeatherScreen(with model: APIWeatherResponse)
}

final class SearchWeatherScreenRouter: SearchWeatherScreenRouterProtocol {
    
    private let factory: CityWeatherScreenFactory
    private weak var root: UIViewController?
    
    init(factory: CityWeatherScreenFactory) {
        self.factory = factory
    }
    func setRootViewController(root: UIViewController) {
        self.root = root
    }
    func openCityWeatherScreen(with model: APIWeatherResponse) {
        let viewController = factory.make(with: model)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}


