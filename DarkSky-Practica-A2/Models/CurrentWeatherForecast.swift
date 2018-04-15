//
//  CurrentWeatherForecast.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import Foundation

struct CurrentWeatherForecast {
    
    let temperature: Float
    
    init(_ raw: RawCurrentWeatherForecast) {
        temperature = raw.temperature
    }
    
}

struct RawCurrentWeatherForecast: Codable {
    
    let temperature: Float
    
}
