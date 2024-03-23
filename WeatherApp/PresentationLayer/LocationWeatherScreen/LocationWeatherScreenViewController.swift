//
//  ViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import UIKit

class LocationWeatherScreenViewController: UIViewController {
    
    let weatherView = LocationWeatherScreenView()
    let presenter: LocationWeatherScreenPresenterProtocol
    
    init(presenter: LocationWeatherScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.isHidden = true
        view.addSubview(weatherView)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension LocationWeatherScreenViewController: LocationWeatherScreenViewProtocol {
    func setup(weather: LocationWeatherModel) {
        weatherView.setup(weather: weather)
        DispatchQueue.main.async {
            self.weatherView.isHidden = false
        }
    }
}
