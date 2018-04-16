//
//  WeatherService.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import CoreLocation
import Foundation

private struct WeatherInfo: Codable {
    
    let currently: RawCurrentWeatherForecast
    let daily: RawDailyWeatherForecast
    
}

class WeatherSerivce {

    private let darkSkyScheme = "https"
    private let darkSkyKey = ""
    private let darkSkyHost = "api.darksky.net"
    
    private func darkSkyURLFor(coordinate: CLLocationCoordinate2D) -> URL? {
        var components = URLComponents()
        components.scheme = darkSkyScheme
        components.host = darkSkyHost
        components.path = darkSkyPathFor(coordinate: coordinate)
        
        return components.url
    }
    
    private func darkSkyPathFor(coordinate: CLLocationCoordinate2D) -> String {
        return "/forecast/\(darkSkyKey)/\(coordinate.latitude),\(coordinate.longitude)"
    }
    
    func fetchCurrentWeatherForecastFor(location: CLLocation, completion: @escaping (CurrentWeatherForecast) -> ()) {
        
        guard let url = darkSkyURLFor(coordinate: location.coordinate) else {
            print("could not construct url")
            return
        }
        
        NetworkManager.getDataFor(url: url) { (data) in
            do {
                let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
                let currentForecast = CurrentWeatherForecast(weatherInfo.currently)
                print("currentForecast: \(currentForecast.temperature)")
                completion(currentForecast)
            }
            catch {
                print("could not parse data into models")
            }
        }
    }
}

