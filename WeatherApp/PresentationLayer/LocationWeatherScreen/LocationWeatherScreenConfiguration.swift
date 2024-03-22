//
//  LocationWeatherScreenConfiguration.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

//import UIKit
//
//final class LocationWeatherScreenConfiguration {
//    private let networkManager: NetworkManagerProtocol
//    
//    init(
//        networkManager: NetworkManagerProtocol
//    ) {
//        self.networkManager = networkManager
//    }
//    
//    func config(
//        view: UIViewController,
//        navigationController: UINavigationController
//    ) {
//        guard let view = view as? LocationWeatherScreenViewController else { return }
//        let presenter = WeatherScreenPresenter(view: view)
//        let dataSourceProvider: IWeatherScreenDataSourceProvider = WeatherScreenDataSourceProvider()
//        let router = WeatherScreenRouter(withNavigationController: navigationController)
//        
//        view.presenter = presenter
//        view.dataSourceProvider = dataSourceProvider
//        presenter.view = view
//        presenter.router = router
//        
//        presenter.networkManager = networkManager
//        presenter.userDefaultsService = userDefaultsService
//    }
//}
