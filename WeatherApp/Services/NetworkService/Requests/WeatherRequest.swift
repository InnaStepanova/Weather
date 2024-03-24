//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

struct WeatherRequest: URLRequestProtocol {
    var urlRequest: URLRequest?
    var urlString: String
    
    init(urlString: String) {
        print(urlString)
        self.urlString = urlString
        urlRequest = request(stringURL: urlString)
        
    }
    
    mutating func request(stringURL: String) -> URLRequest? {
        if let url = URL(string: stringURL) {
            urlRequest = URLRequest(url: url, timeoutInterval: 30)
        } else {
            return nil
        }
        return urlRequest
    }
}
