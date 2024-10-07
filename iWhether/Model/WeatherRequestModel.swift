//
//  WeatherRequestModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation

struct WeatherRequestModel: Decodable {
    let city: String
    let latitude: String
    let longitude: String
    let excludeFields: String
    let units: String
}
