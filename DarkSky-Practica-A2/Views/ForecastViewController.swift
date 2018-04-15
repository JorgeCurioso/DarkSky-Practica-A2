//
//  ForecastViewController.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let weatherService = WeatherSerivce()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.fetchCurrentWeatherForecast {
            DispatchQueue.main.async {

                
            }
        }
    }

}
