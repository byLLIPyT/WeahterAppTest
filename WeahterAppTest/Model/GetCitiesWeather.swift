//
//  GetCitiesWeather.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import Foundation
import CoreLocation

let networkManager = NetworkWeatherManager()

func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, Weather) -> Void) {
    
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }
            networkManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completionHandler(index, weather)
            }
        }
    }
}

func checkCoordinate(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { (coord, error) in
        completion(coord?.first?.location?.coordinate, error)
    }    
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}

