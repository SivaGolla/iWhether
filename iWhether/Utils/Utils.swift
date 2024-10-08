//
//  Utils.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 08/10/24.
//

import Foundation

struct Utils {
    /// Returns the weather icon name for a given daily weather forecast.
    ///
    /// - Parameter weather: The `WeatherDaily` object for which to retrieve the icon name.
    /// - Returns: The corresponding icon name as a string.
    ///
    static func iconNameFor(weather: WeatherDaily) -> String {
        return (weather.weather.first?.icon ?? "sun").wIconName
    }
}


