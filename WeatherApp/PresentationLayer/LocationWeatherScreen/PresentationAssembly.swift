//
//  PresentationAssembly.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//


import Foundation

final class PresentationAssembly {
    private var service = ServiceAssembly()
    
    // FIXME: Пока не стал разделять зависимости, но знаю что это место не для неё
    private lazy var networkManager: NetworkManagerProtocol = NetworkManager(
        requestService: service.requestService
    )
    
//    lazy var locationWeatherScreen: LocationWeatherScreenConfigurator = {
//        return LocationWeatherScreenConfigurator(
//            networkManager: networkManager)
//    }()
    
//    lazy var cityListScreen: CityListScreenConfigurator = {
//        return CityListScreenConfigurator(
//            userDefaultsService: service.userDefaultsService,
//            coreDataService: service.coreDataService,
//            logger: service.logger
//        )
//    }()
}
