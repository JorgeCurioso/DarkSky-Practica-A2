//
//  WeatherService.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import Foundation

private struct WeatherInfo: Codable {
    
    let currently: RawCurrentWeatherForecast
    let daily: RawDailyWeatherForecast
    
}

class WeatherSerivce {
    //gather credentials
//    https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589
    private let latitude = 42.3601
    private let longitude = -71.0589
    private let darkSkyScheme = "https"
    private let darkSkyHost = "api.darksky.net"
    
    private func darkSkyURL() -> URL? {
        var components = URLComponents()
        components.scheme = darkSkyScheme
        components.host = darkSkyHost
        components.path = darkSkyPath()
        
        return components.url
    }
    
    private func darkSkyPath() -> String {
        return "/forecast/\(darkSkyKey)/\(latitude),\(longitude)"
    }
    
    func fetchCurrentWeatherForecast(completion: () -> ()) {
        guard let url = darkSkyURL() else {
            print("could not construct url")
            return
        }
        
        NetworkManager.getDataFor(url: url) { (data) in
            //take data and parse into models
            do {
                let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
                let currentForecast = CurrentWeatherForecast(weatherInfo.currently)
                print("currentForecast: \(currentForecast.temperature)")
            }
            catch {
                print("could not parse data into models")
            }
        }
    }
}

