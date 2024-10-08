//
//  WeatherRequestModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation

/// A model representing a weather data request, conforming to `Decodable`.
///
/// This model is used to send a request for weather data, specifying the city, geographical coordinates,
/// and additional parameters such as excluded fields and units of measurement.
///
/// - Properties:
///   - city: The name of the city for which the weather data is requested.
///   - latitude: The latitude of the city's location.
///   - longitude: The longitude of the city's location.
///   - excludeFields: A comma-separated string of weather data fields to exclude from the response.
///   - units: The unit system to use for temperature and other weather metrics (e.g., metric, imperial).
struct WeatherRequestModel: Decodable {
    let city: String
    let latitude: String
    let longitude: String
    let excludeFields: String
    let units: String
}
