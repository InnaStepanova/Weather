//
//  CityWeatherScreenFactory.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

final class CityWeatherScreenFactory {
   
    func make(with param: APIWeatherResponse) -> UIViewController {
        let presenter = CityWeatherScreenPresenter(contex: param)
        let vc = CityWeatherSCreenViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
