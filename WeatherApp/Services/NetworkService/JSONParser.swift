//
//  JSONParser.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

protocol JSONParserProtocol {
    associatedtype Model
    func parse(data: Data) -> Model?
}

final class JSONParser<Model: Codable>: JSONParserProtocol {
    func parse(data: Data) -> Model? {
        var model: Model?
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            model = try decoder.decode(Model.self, from: data)
        } catch {
            return nil
        }
        return model
    }
}
