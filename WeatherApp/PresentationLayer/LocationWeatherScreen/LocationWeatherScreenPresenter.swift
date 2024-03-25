//
//  LocationWeatherScreenPresenter.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.

import UIKit
import CoreLocation

protocol LocationWeatherScreenPresenterProtocol: AnyObject {
    func updateData()
    // Метод который подготавливает текущую модель к показу, а именно - данные отобржемые в главной части экрана - те данные которые были в моделе на данное время суток (интервал 3 часа в API), данные в таблице - это обобщенные данные по всем ответам от API
    func getCurrentViewModel(from model: LocationWeatherModel) -> CityWeatherViewModel?
}

final class LocationWeatherScreenPresenter: LocationWeatherScreenPresenterProtocol {
    
    weak var view: LocationWeatherScreenViewProtocol?
    let networkManader: NetworkManagerProtocol
    let locationManager: LocationManagerProtocol
    let cacheManager: CacheManager
    
    init(networkManader: NetworkManagerProtocol, locationManager: LocationManagerProtocol, cacheManager: CacheManager) {
        self.networkManader = networkManader
        self.locationManager = locationManager
        self.cacheManager = cacheManager
    }
    
    func updateData() {
        locationManager.getCurrentCity { [weak self] city in
            guard let self = self else {return}
            if let city = city {
                //  Если есть валидный ответ в кэше используем его
                if let weather = cacheManager.objectForKey(city) {
                    let model = weather.weather //API Model
                    print("FROM CACHE")
                    let weather = LocationWeatherModel(serverModel: model)

                    if let viewModel = self.getCurrentViewModel(from: weather) {
                        self.view?.setup(weather: viewModel)
                    }
                } else {
                    // если нет то получаем данные из интернета
                    self.networkManader.getWeatherFor(city: city) { result in
                        switch result {
                        case .success(let serverModel):
                            self.cacheManager.setObject(CacheModel(weather: serverModel), forKey: city) // сразу сохраняем в кэш
                            let weather = LocationWeatherModel(serverModel: serverModel)
                            if let viewModel = self.getCurrentViewModel(from: weather) {
                                self.view?.setup(weather: viewModel)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

extension LocationWeatherScreenPresenterProtocol {
    func getCurrentViewModel(from model: LocationWeatherModel) -> CityWeatherViewModel? {
        let currentDate = Date()
        let currentTimeInterval = currentDate.timeIntervalSince1970
        
        //Получаем дату и время получения прогноза из текущей модели
        guard let startTimeInterval = model.weather.first?.date else {return nil}
        //Проверяем что текущая модель была получена менеее суток назад
        if currentTimeInterval - startTimeInterval < 86_400 {
            //Модель актуальна, получаем прогноз на текущее время дня
            var currentWeather: Weather? = nil
            for weather in model.weather {
                if currentTimeInterval < weather.date { //ищем первую дату и время больше текущего для получения актуального прогноза
                    currentWeather = weather
                    break
                }
            }
            
            let calendar = Calendar.current
            
            var dictWeather: [DateComponents:[Int]] = [:]
            
            for weather in model.weather {
                let date = Date(timeIntervalSince1970: weather.date)
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                if let existingValues = dictWeather[components] {
                    var updatedValues = existingValues
                    updatedValues.append(weather.temp)
                    dictWeather.updateValue(updatedValues, forKey: components)
                } else {
                    dictWeather[components] = [weather.temp]
                }
            }
            let weathers = convertToViewModels(locationWeatherModel: model)
            if let currentWeather = currentWeather {
                return CityWeatherViewModel(
                    city: model.city,
                    temperature: currentWeather.temp,
                    pressure: currentWeather.pressure,
                    humidity: currentWeather.humidity,
                    description: currentWeather.description,
                    windSpeed: currentWeather.windSpeed,
                    weather: weathers)
            }
            return nil
        } else {
            return nil // модель устарела возвращаем nil
        }
    }
    
    func convertToViewModels(locationWeatherModel: LocationWeatherModel) -> [WeatherViewModel] {
        var weatherViewModels: [WeatherViewModel] = []
        
        let groupedWeatherByDay = Dictionary(grouping: locationWeatherModel.weather) { weather in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: Date(timeIntervalSince1970: weather.date))
            return calendar.date(from: components)
        }
        
        for (_, weatherGroup) in groupedWeatherByDay {
            guard let date = weatherGroup.first?.date else { continue }
            
            let minTemp = weatherGroup.min(by: { $0.temp < $1.temp })?.temp ?? 0
            let maxTemp = weatherGroup.max(by: { $0.temp < $1.temp })?.temp ?? 0
            
            let descriptionIds = weatherGroup.map { $0.weatherId }
            let mostFrequentDescriptionId = descriptionIds.reduce(into: [:]) { counts, id in counts[id, default: 0] += 1 }
                .max { $0.1 < $1.1 }?.key ?? 0
            
            let dateFormatted = formatDate(Date(timeIntervalSince1970: date))
            
            let viewModel = WeatherViewModel(minTemp: minTemp, maxTemp: maxTemp, descriptionId: mostFrequentDescriptionId, date: dateFormatted)
            weatherViewModels.append(viewModel)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        let sortedArray = weatherViewModels.sorted {
            if let date1 = formatter.date(from: $0.date),
               let date2 = formatter.date(from: $1.date) {
                return date1 < date2
            } else {
                return false
            }
        }
        return sortedArray
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
