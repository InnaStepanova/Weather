//
//  SearchWeatherScreenPresenter.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import Foundation

protocol SearchWeatherScreenPresenterProtocol: AnyObject {
    func cheak(city: String) 
    func cityNotFind()
}

final class SearchWeatherScreenPresenter {
    
    weak var view: SearchWeatherScreenViewProtocol?
    let networkManader: NetworkManagerProtocol
    let cacheManager: CacheManager2
    let router: SearchWeatherScreenRouterProtocol
    
    init(
        networkManader: NetworkManagerProtocol,
        cacheManager: CacheManager2,
        router: SearchWeatherScreenRouterProtocol) {
            self.networkManader = networkManader
            self.cacheManager = cacheManager
            self.router = router
    }
}

extension SearchWeatherScreenPresenter: SearchWeatherScreenPresenterProtocol {
    
    func cityNotFind() {
        view?.showMessage()
    }
    
    func cheak(city: String) {
        if let weather = cacheManager.objectForKey(city) {
            let model = weather.weather
            print("FROM CACHE")
            router.openCityWeatherScreen(with: model)
        } else {
            networkManader.getWeatherFor(city: city) { [weak self] result in
                switch result {
                case .success(let responce):
                    self?.cacheManager.setObject(CacheModel(weather: responce), forKey: city)
                    DispatchQueue.main.async {
                        self?.router.openCityWeatherScreen(with: responce)
                    }
                    print("Ура")
                case .failure(let error):
                    self?.cityNotFind()
                }
            }
        }
    }
}
