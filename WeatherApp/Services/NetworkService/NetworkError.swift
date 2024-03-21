//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

enum NetworkError: Error {
    case authError
    case messageError(String)
    case serverUnavailable
    case unownedError
    case invalidURL
    case networkError
    case statusCodeError
    case parseError
    case notFound
    
    var describing: String {
        switch self {
        case .authError:
            return "Ошибка авторизации"
        case .messageError(let message):
            return message
        case .serverUnavailable:
            return "Упал сервер"
        case .unownedError:
            return "Неизвестная ошибка. До свидания"
        case .invalidURL:
            return "API Error: Неправильно указан URL."
        case .networkError:
            return "Ошибка сети. Попробовать загрузить данные еще раз?"
        case .statusCodeError:
            return "Ошибка получения кода статуса"
        case .parseError:
            return "Ошибка парсинга данных"
        case .notFound:
            return "Неудачный запрос, не найдено на сервере"
        }
    }
}
