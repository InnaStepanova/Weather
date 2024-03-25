//
//  SearchWeatherScreenFactory.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

final class SearchWeatherScreenFactory {

    func make() -> UIViewController {
        let cityWeatherFactory = CityWeatherScreenFactory()
        let router = SearchWeatherScreenRouter(factory: cityWeatherFactory)
        let cacheManager = CacheManager.shared
        let request = RequestSender()
        let networkManager = NetworkManager(requestService: request)
        
        let presenter = SearchWeatherScreenPresenter(
            networkManader: networkManager,
            cacheManager: cacheManager,
            router: router)
        
        let vc = SearchWeatherScreenViewController(presenter: presenter)
        
        presenter.view = vc
        router.setRootViewController(root: vc)
        
        return vc
    }
}
