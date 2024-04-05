//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Damla Sahin on 5.04.2024.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Rain: Codable {
    let h1: Double?
    
    enum CodingKeys: String, CodingKey {
        case h1 = "1h"
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

