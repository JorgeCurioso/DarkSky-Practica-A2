//
//  NetworkManager.swift
//  DarkSky-Practica-A2
//
//  Created by George Royce on 4/15/18.
//  Copyright © 2018 George Royce. All rights reserved.
//

import Foundation


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
