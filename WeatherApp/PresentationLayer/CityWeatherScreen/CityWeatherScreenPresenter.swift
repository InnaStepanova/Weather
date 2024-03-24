//
//  CityWeatherScreenPresenter.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

final class CityWeatherScreenPresenter {
    
    weak var view: LocationWeatherScreenViewProtocol?
    let networkManader: NetworkManagerProtocol
    private var city: String
    
    init(networkManader: NetworkManagerProtocol, contex: CityWeatherScreenFactory.Contex) {
        self.networkManader = networkManader
        self.city = contex.param
        print("CONTEX INIT - \(contex.param)")
    }
}

extension CityWeatherScreenPresenter: LocationWeatherScreenPresenterProtocol {
    func setupView() {
        print("City - \(city)")
        networkManader.getWeatherFor(city: city) { result in
            switch result {
            case .success(let serverModel):
                let weather = LocationWeatherModel(serverModel: serverModel)
                self.view?.setup(weather: weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}
