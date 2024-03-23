//
//  LocationWeatherModuleFactory.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import UIKit

final class LocationWeatherModuleFactory {

    func make() -> UIViewController {
        
        let requestSender = RequestSender()
        let networkManager = NetworkManager(requestService: requestSender)
        let locationManager = LocationManager()
        
        let presenter = LocationWeatherScreenPresenter(networkManader: networkManager, locationManager: locationManager)
        let vc = LocationWeatherScreenViewController(presenter: presenter)
        
        presenter.view = vc
        locationManager.presenter = presenter
        
        return vc
    }
}
