//
//  WeatherResponse.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation

struct WeatherResponse: Codable {
    var current: Weather
    var hourly: [Weather]
    var daily: [WeatherDaily]

    init() {
        self.current = Weather()
        self.hourly = [Weather](repeating: Weather(), count: 24)
        self.daily = [WeatherDaily](repeating: WeatherDaily(), count: 8)
    }
}

struct Weather: Codable, Identifiable {
    var date: Double
    var temperature: Double
    var feelsLike: Double
    var pressure: Int
    var humidity: Int
    var dewPoint: Double
    var clouds: Int
    var windSpeed: Double
    var windDeg: Int
    var weather: [WeatherDetail]
    var id: UUID {
        UUID()
    }

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case clouds = "clouds"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather = "weather"
    }

    init() {
        date = 0
        temperature = 0.0
        feelsLike = 0.0
        pressure = 0
        humidity = 0
        dewPoint = 0.0
        clouds = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
    }
}

struct WeatherDetail: Codable, Identifiable {
    var main: String
    var description: String
    var icon: String
    var id: Int {
        0
    }
    
    init() {
        main = ""
        description = ""
        icon = ""
    }
}

struct WeatherDaily: Codable, Identifiable {
    var date: Double
    var temperature: Temperature
    var weather: [WeatherDetail]
    var id: UUID {
        UUID()
    }

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case weather = "weather"
    }

    init() {
        date = 0
        temperature = Temperature(min: 0.0, max: 0.0)
        weather = [WeatherDetail()]
    }
}

struct Temperature: Codable {
    var min: Double
    var max: Double
}
