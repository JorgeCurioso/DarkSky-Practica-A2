//
//  ForecastViewController.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private var manager: CLLocationManager?

    private let weatherService = WeatherSerivce()
    private let lastLocationNotificationName = "lastLocation"
    private var lastLocation: CLLocation? {
        didSet {
            fetchForecast()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager = CLLocationManager()
        self.manager?.delegate = self
        requestPermissionIfNecessary()
    }
    
    func fetchForecast() {
        weatherService.fetchCurrentWeatherForecastFor(location: lastLocation!) { currentWeatherForecast in
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(currentWeatherForecast.roundedTemperature)º"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("tra la la, authorized")
            //something happens
            self.manager?.startUpdatingLocation()
        default:
            print(status)
            //stop updating location
            self.manager?.stopUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.first else {
            print("could not grab last location")
            return
        }
        self.lastLocation = lastLocation
        self.manager?.stopUpdatingLocation()
    }
    
    func requestPermissionIfNecessary() {
        if CLLocationManager.locationServicesEnabled() {
            self.manager?.startUpdatingLocation()
        } else {
            self.manager?.requestWhenInUseAuthorization()
        }
    }
}
