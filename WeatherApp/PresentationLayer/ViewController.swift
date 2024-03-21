//
//  ViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        NetworkManager(requestService: RequestSender()).getWeatherFor(city: "Москва") { result in
            switch result {
            case .success(let weatherResponce): print("WEATHER RESPONCE: \(weatherResponce)")
            case .failure(let error): print(error)
            }
        }
    }


}

