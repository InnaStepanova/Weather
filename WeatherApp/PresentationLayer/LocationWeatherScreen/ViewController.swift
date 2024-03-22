//
//  ViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let weather = LocationWeatherScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkManager(requestService: RequestSender()).getWeatherFor(city: "Москва") { result in
//            switch result {
//            case .success(let weatherResponce): print("WEATHER RESPONCE: \(weatherResponce)")
//            case .failure(let error): print(error)
//            }
//        }
        
        view.addSubview(weather)
        
        weather.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weather.topAnchor.constraint(equalTo: view.topAnchor),
            weather.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weather.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weather.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }


}

