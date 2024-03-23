//
//  URLProvider.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

public struct URLProvider {
    public static func fetchApiStringURL(
        with token: String,
        for city: String) -> String {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&APPID=\(token)&units=metric&lang=ru"
        return urlString
    }
}
