//
//  Weather.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation

class Weather {
    static var shared = Weather()
    private init() {} //allows you to have only one Weather class
    static var searchCity = "London"
    private var task: URLSessionDataTask?
    private var weatherSession = URLSession(configuration: .default)
    init(weatherSession: URLSession){
        self.weatherSession = weatherSession
    }
    
}

extension Weather {
    
   private func weatherRequest() -> URL {
       let weatherAPI = "https://api.openweathermap.org/data/2.5/weather?"
       let apiKEY = "8bc788550c1e87a3b97b2e89a3135b30"
       let weatherCity = Weather.searchCity
       let unitsWeather = "metric"
       let weatherURL = URL(string: "\(weatherAPI)q=\(weatherCity)&APPID=\(apiKEY)&units=\(unitsWeather)")
       return weatherURL!
    }
    
    func getWeather(callback: @escaping (Bool, WeatherJSONStructure?) -> Void) {
        let weatherURL = weatherRequest()
        
        task?.cancel()
        task = weatherSession.dataTask(with: weatherURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherJSONStructure.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}


/*

 
 */
