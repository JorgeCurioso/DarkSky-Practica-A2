//
//  WeatherService.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import Foundation

class WeatherSerivce {
    //gather credentials
//    https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589
    private let latitude = 42.3601
    private let longitude = -71.0589
    private let darkSkyScheme = "https"
    private let darkSkyHost = "api.darksky.net"
    private let darkSkyKey = ""
    
    //compose url
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
    
    //pass url in to NetworkManager to fetch data
    func fetchCurrentWeatherForecast(completion: () -> ()) {
        guard let url = darkSkyURL() else {
            print("could not construct url")
            return
        }
        
        NetworkManager.getDataFor(url: url) { (data) in
            //take data and parse into models
            
        }
    }
}

class NetworkManager {
    
    class func getDataFor(url: URL, completion: @escaping (Data) -> ()) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, response, error) in
            guard let responseData = data else {
                print("could not gather data")
                return
            }
            print(response.debugDescription)
            completion(responseData)
            
        }.resume()
        
    }
    
}
