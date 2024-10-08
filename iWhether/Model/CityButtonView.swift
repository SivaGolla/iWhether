//
//  CityButtonView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import Foundation

/// A view model representing a city button, conforming to `Identifiable` and `Codable`.
///
/// Each instance of `CityButtonView` is uniquely identified by a `UUID` and stores the name of the city.
///
/// - Properties:
///   - id: A unique identifier for the city button, generated automatically.
///   - cityName: The name of the city displayed on the button.
///   
struct CityButtonView: Identifiable, Codable {
    var id: UUID = UUID()
    var cityName: String = ""
//    var conditions: String = "Cloudy"
//    var temperature: String = "11º"
//    var minTemperature: String = "5º"
//    var maxTemperature: String = "15º"
}
