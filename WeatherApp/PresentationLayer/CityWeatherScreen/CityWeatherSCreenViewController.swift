//
//  CityWeatherSCreenViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

protocol CityWeatherScreenViewProtocol {
    
}

class CityWeatherSCreenViewController: UIViewController {
    
    let weatherView = LocationWeatherScreenView()
    let presenter: CityWeatherScreenPresenter
    
    init(presenter: CityWeatherScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
//    init(weather: CityWeatherViewModel) {
//            self.weatherView = LocationWeatherScreenView(with: weather)
//            super.init(nibName: nil, bundle: nil)
//        }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        print("INIT VC")
        super.viewDidLoad()
        view.addSubview(weatherView)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        presenter.updateData()
    }

}

extension CityWeatherSCreenViewController: LocationWeatherScreenViewProtocol {
    
    func setup(weather: CityWeatherViewModel) {
        weatherView.setup(weather: weather)
    }
}
