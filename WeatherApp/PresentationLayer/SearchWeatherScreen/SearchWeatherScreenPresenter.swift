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
    let cacheManager: CacheManager
    let router: SearchWeatherScreenRouterProtocol
    
    init(
        networkManader: NetworkManagerProtocol,
        cacheManager: CacheManager,
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
        //  Если есть валидный ответ в кэше используем его
        if let weather = cacheManager.objectForKey(city) {
            let model = weather.weather
            router.openCityWeatherScreen(with: model)
        } else {
            // если нет то получаем данные из интернета
            networkManader.getWeatherFor(city: city) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let responce):
                    self.cacheManager.setObject(CacheModel(weather: responce), forKey: city) // сразу сохраняем в кэш
                    DispatchQueue.main.async {
                        self.router.openCityWeatherScreen(with: responce)
                    }
                case .failure(let error):
                    self.cityNotFind()
                }
            }
        }
    }
}
