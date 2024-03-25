//
//  CacheManager.swift
//  WeatherApp
//
//  Created by Лаванда on 25.03.2024.
//

import Foundation

class CacheModel {
    let weather: APIWeatherResponse
    
    init(weather: APIWeatherResponse) {
        self.weather = weather
    }
}
class CacheManager2 {
    
    static let shared = CacheManager2()
    
    private let cache = NSCache<NSString, CacheModel>()
    
    func setObject(_ object: CacheModel, forKey key: String) {
        cache.setObject(object, forKey: NSString(string: key))
    }
    
    func objectForKey(_ key: String) -> CacheModel? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func removeObjectForKey(_ key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
}
