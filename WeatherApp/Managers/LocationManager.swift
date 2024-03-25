//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import CoreLocation

protocol LocationManagerProtocol {
    var currentCity: String? { get set }
    func getCurrentCity(completion: @escaping (String?) -> Void)
}

class LocationManager: NSObject, LocationManagerProtocol {
    
    private var locationManager = CLLocationManager()
    var currentCity: String? {
        didSet{
            presenter?.updateData()
        }
    }
    weak var presenter: LocationWeatherScreenPresenterProtocol?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentCity(completion: @escaping (String?) -> Void) {
        if let city = currentCity {
            completion(city)
        } else {
            completion(nil)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocode failed with error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    self.currentCity = city
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}


