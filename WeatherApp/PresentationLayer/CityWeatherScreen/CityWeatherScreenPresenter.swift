//
//  CityWeatherScreenPresenter.swift
//  WeatherApp
//
//  Created by Лаванда on 24.03.2024.
//

import UIKit

final class CityWeatherScreenPresenter {
    
    weak var view: LocationWeatherScreenViewProtocol?
    private var apiModel: APIWeatherResponse
    
    init(contex: APIWeatherResponse) {
        self.apiModel = contex
    }
    
}

extension CityWeatherScreenPresenter: LocationWeatherScreenPresenterProtocol {
    func updateData() {
        let locationModel = LocationWeatherModel(serverModel: apiModel)
        if let viewModel = getCurrentViewModel(from: locationModel) {
            view?.setup(weather: viewModel)}
    }
}
