//
//  Image+Custom.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation

extension String {
    var wIconName: String {
        switch self {
        case "01d":
            return "sun"
        case "01n":
            return "moon"
        case "02d":
            return "cloudSun"
        case "02n":
            return "cloudMoon"
        case "03d":
            return "cloud"
        case "03n":
            return "cloudMoon"
        case "04d":
            return "cloudMax"
        case "04n":
            return "cloudMoon"
        case "09d":
            return "rainy"
        case "09n":
            return "rainy"
        case "10d":
            return "rainySun"
        case "10n":
            return "rainyMoon"
        case "11d":
            return "thunderstormSun"
        case "11n":
            return "thunderstormMoon"
        case "13d":
            return "snowy"
        case "13n":
            return "snowy-2"
        case "50d":
            return "tornado"
        case "50n":
            return "tornado"
        default:
            return "sun"
        }
    }
}
