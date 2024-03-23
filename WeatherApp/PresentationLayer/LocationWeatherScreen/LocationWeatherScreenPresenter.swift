//
//  LocationWeatherScreenPresenter.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.

import UIKit
import CoreLocation

protocol LocationWeatherScreenPresenterProtocol: AnyObject {
    func setupView()
}

final class LocationWeatherScreenPresenter: LocationWeatherScreenPresenterProtocol {
  
    weak var view: LocationWeatherScreenViewProtocol?
    let networkManader: NetworkManagerProtocol
    let locationManager: LocationManagerProtocol
    
    init(networkManader: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManader = networkManader
        self.locationManager = locationManager
    }
    
    func setupView() {
        locationManager.getCurrentCity { [weak self] city in
            guard let self = self else {return}
            if let city = city {
                self.networkManader.getWeatherFor(city: city) { result in
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
    }
}
