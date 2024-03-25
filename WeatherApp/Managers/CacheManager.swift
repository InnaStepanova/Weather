//
//  CacheManager.swift
//  WeatherApp
//
//  Created by Лаванда on 25.03.2024.
//

import Foundation

class CacheModel {
    let date = Date()
    let weather: APIWeatherResponse
    
    init(weather: APIWeatherResponse) {
        self.weather = weather
    }
}
class CacheManager {
    
    static let shared = CacheManager()
    
    private let cache = NSCache<NSString, CacheModel>()
    
    func setObject(_ object: CacheModel, forKey key: String) {
        cache.setObject(object, forKey: NSString(string: key))
        print("ЗАПИСЬ В КЭШ по ключу \(key)")
    }
 
    
    func objectForKey(_ key: String) -> CacheModel? {
        // если объект есть в кэш то проверяем как давно он там нходится, если больше суток то считаем такой прогноз не актуальным и возращаем nil
        if let cache = cache.object(forKey: NSString(string: key)) {
            let currentDate = Date()
            let timeInterval = currentDate.timeIntervalSince(cache.date)
            if timeInterval < 86400 {
                return cache
            } else {
                removeObjectForKey(key) // удаляем устревший объект
            }
        }
        return nil
    }
    
    func removeObjectForKey(_ key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
}
