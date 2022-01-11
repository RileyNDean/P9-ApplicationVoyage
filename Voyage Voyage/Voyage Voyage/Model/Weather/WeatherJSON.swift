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
