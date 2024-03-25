//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Лаванда on 25.03.2024.
//

import Foundation

struct CityWeatherViewModel {
    let city: String
    let temperature: Int
    let pressure: Int
    let humidity: Int
    let description: String
    let windSpeed: Int
    let weather: [WeatherViewModel]
}

struct WeatherViewModel {
    let minTemp: Int
    let maxTemp: Int
    let descriptionId: Int
    let date: String
}

