//
//  Weather.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation

class Weather {
    static var shared = Weather()
    private init() {
        self.weatherSession = URLSession(configuration: .default)
    } //allows you to have only one Weather class
    static var citySearched = "New York"
    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }

}

extension Weather {
    
    func getWeather(_ citySearched: String,callback: @escaping (Bool, WeatherData?) -> Void) {
        let weatherURL = weatherURLRequest(citySearched)
        
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
                let temp = responseJSON.main?.temp!
                let description = responseJSON.weather[0]?.description
                let icon = responseJSON.weather[0]?.icon
                callback(true, WeatherData(temp: temp!, description: description!, icon: icon!))
            }
        }
        task?.resume()
    }
    
    //get URL for the request GET
    private func weatherURLRequest(_ citySearched: String) -> URL {
        let weatherAPI = "https://api.openweathermap.org/data/2.5/weather?"
        let apiKEY = "8bc788550c1e87a3b97b2e89a3135b30"
        let weatherCity =  citySearched.withReplacedCharacters(" ", by: "%20") //Replace whitespace
        let unitsWeather = "metric"
        let weatherURL = URL(string: "\(weatherAPI)q=\(weatherCity)&APPID=\(apiKEY)&units=\(unitsWeather)")
        return weatherURL!
     }
}
