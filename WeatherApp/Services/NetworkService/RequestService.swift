//
//  RequestService.swift
//  WeatherApp
//
//  Created by Лаванда on 21.03.2024.
//

import Foundation

protocol URLRequestProtocol {
    var urlRequest: URLRequest? { get }
}

protocol RequestSenderProtocol {
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
    )
}

struct RequestConfig<Parser> where Parser: JSONParserProtocol {
    let request: URLRequestProtocol
    let parser: Parser?
}

final class RequestSender: RequestSenderProtocol {
    
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
    ) where Parser: JSONParserProtocol {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            let result: Result<(Parser.Model?, Data?, URLResponse?), NetworkError>
            
            defer {
                completionHandler(result)
            }
            
            if let _ = error {
                result = .failure(.networkError)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                result = .failure(.statusCodeError)
                return
            }
            
            if !(200..<300).contains(statusCode) {
                
                switch statusCode {
                case 400:
                    let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    result = .failure(.messageError(serverMessage))
                    return
                case 401:
                    result = .failure(.authError)
                    return
                case 404:
                    result = .failure(.notFound)
                    return
                case 500...:
                    result = .failure(.serverUnavailable)
                    return
                default:
                    let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    result = .failure(.messageError(serverMessage))
                    return
                }
            }
            
            if let data = data,
               let parseModel: Parser.Model = config.parser?.parse(data: data) {
                result = .success((parseModel, nil, nil))
            } else if let data = data {
                // кейс на случай, когда не нужно парсить модель, но ответ получить нужно
                result = .success((nil, data, response))
            } else {
                result = .failure(.parseError)
            }
        }
        task.resume()
    }
}
