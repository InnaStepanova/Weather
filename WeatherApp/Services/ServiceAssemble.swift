//
//  ServiceAssemble.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import Foundation


final class ServiceAssembly {
    
    lazy var requestService: RequestSenderProtocol = {
        return RequestSender()
    }()
}
