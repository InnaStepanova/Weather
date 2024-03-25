//
//  LocationWeatherModel.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import Foundation

struct LocationWeatherModel {
    let city: String
    let weather: [Weather]
}

struct Weather {
    let date: TimeInterval
    let temp: Int
    let description: String
    let pressure: Int
    let humidity: Int
    let windSpeed: Int
    let weatherId: Int
}

extension LocationWeatherModel {
    init(serverModel: APIWeatherResponse) {
        var weathers = [Weather]()
        for weather in serverModel.list {
            let weather = Weather(
                date: weather.dt,
                temp: Int(round(weather.main.temp)),
                description: weather.weather.first?.description ?? "",
                pressure: weather.main.pressure,
                humidity: weather.main.humidity,
                windSpeed: Int(round(weather.wind.speed)),
                weatherId: weather.weather.first?.id ?? 801) // 801 - вернет иконку облачно в случает отсутствия значений
            weathers.append(weather)
        }
        self.init(
            city: serverModel.city.name,
            weather: weathers)
    }
}
