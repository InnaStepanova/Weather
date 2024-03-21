//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getWeatherFor(
        city: String,
        completion: @escaping (Result<APIWeatherResponse, NetworkError>) -> Void
    )
}

final class NetworkManager {
    // MARK: - Dependencies
    
    private let requestService: RequestSenderProtocol
    
    // MARK: - Initializer
    
    init(
        requestService: RequestSenderProtocol
    ) {
        self.requestService = requestService
    }
}

// MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    func getWeatherFor(
        city: String,
        completion: @escaping (Result<APIWeatherResponse, NetworkError>) -> Void
    ) {
        let requestConfig = RequestFactory.WeatherDataRequest.weatherModelConfig(for: city)
        
        requestService.send(config: requestConfig) { result in
            switch result {
            case .success(let (model, _, _)):
                guard let model else {
                    completion(.failure(.notFound))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

