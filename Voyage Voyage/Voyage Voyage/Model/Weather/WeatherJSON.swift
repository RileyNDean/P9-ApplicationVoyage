//
//  WeatherJSON.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation


struct WeatherJSONStructure {
    let weather: [WeatherStructure?]
    let main: MainStructure?
}
extension WeatherJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case main = "main"
    }
}
struct WeatherStructure {
    let description: String?
    let icon: String?
}
extension WeatherStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case icon = "icon"
    }
}
struct MainStructure {
    let temp: Float?
}
extension MainStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}

/*
 
 ("{\"coord\":{\"lon\":-0.1257,\"lat\":51.5085},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03n\"}],\"base\":\"stations\",\"main\":{\"temp\":279.18,\"feels_like\":276.5,\"temp_min\":276.88,\"temp_max\":281.54,\"pressure\":1006,\"humidity\":93},\"visibility\":10000,\"wind\":{\"speed\":3.6,\"deg\":220},\"clouds\":{\"all\":40},\"dt\":1641628296,\"sys\":{\"type\":2,\"id\":2019646,\"country\":\"GB\",\"sunrise\":1641629045,\"sunset\":1641658186},\"timezone\":0,\"id\":2643743,\"name\":\"London\",\"cod\":200}")
 
 */
