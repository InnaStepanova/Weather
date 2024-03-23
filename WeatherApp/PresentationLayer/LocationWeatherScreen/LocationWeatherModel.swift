//
//  LocationWeatherModel.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import Foundation

struct LocationWeatherModel {
    let city: String
    let currentTemp: Int?
    let description: String?
    let pressure: Int?
    let humidity: Int?
    let windSpeed: Int?
    let weathers: [Weather]
}

struct Weather {
    let date: String
    let minTemp: Int
    let maxTemp: Int
    let weatherId: Int?
}

extension LocationWeatherModel {
    init(serverModel: APIWeatherResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        var weathers: [Weather] = []
        
        var currentDate = dateFormatter.string(from: Date())
        var temperatures = [Double]()
        
        for weather in serverModel.list {
            let date = Date(timeIntervalSince1970: weather.dt)
            let dateString = dateFormatter.string(from: date)
            if dateString == currentDate {
                temperatures.append(weather.main.temp)
            } else {
                if let min = temperatures.min(), let max = temperatures.max() {
                    let weather = Weather(
                        date: currentDate,
                        minTemp: Int(round(min)),
                        maxTemp: Int(round(max)),
                        weatherId: weather.weather.first?.id)
                    
                    weathers.append(weather)
                    currentDate = dateString
                    temperatures = []
                }
            }
        }
        self.init(
            city: serverModel.city.name,
            currentTemp: Int(round(serverModel.list[0].main.temp)),
            description: serverModel.list[0].weather[0].description,
            pressure: serverModel.list[0].main.pressure,
            humidity: serverModel.list[0].main.humidity,
            windSpeed: Int(round(serverModel.list[0].wind.speed)),
            weathers: weathers)
    }
}
