//
//  CityWeatherScreenFactory.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

final class CityWeatherScreenFactory {
    struct Contex {
        let param: String
    }
    
    func make(with param: CityWeatherScreenFactory.Contex) -> UIViewController {
        
        
        let requestSender = RequestSender()
        let networkManager = NetworkManager(requestService: requestSender)
        
        let presenter = CityWeatherScreenPresenter(networkManader: networkManager, contex: param)
        let vc = CityWeatherSCreenViewController(presenter: presenter)
        
        presenter.view = vc
        
        return vc
    }
}
