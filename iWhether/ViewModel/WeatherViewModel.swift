//
//  WeatherViewModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Foundation
import CoreLocation
import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse = WeatherResponse()
}

extension WeatherViewModel {
    var date: String {
        return DateFormatter.wDefault.string(from: Date(timeIntervalSince1970: weather.current.date))
    }

    var weatherIcon: String {
        return weather.current.weather.first?.icon ?? "sun"
    }

    var temperature: String {
        return getTempFor(weather.current.temperature)
    }

    var conditions: String {
        return weather.current.weather.first?.main ?? ""
    }

    var windSpeed: String {
        return String(format: "%0.1f", weather.current.windSpeed)
    }

    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }

    var rainChances: String {
        return String(format: "%0.1f%%", weather.current.dewPoint)
    }

    func getTimeFor(_ temp: Int) -> String {
        return DateFormatter.wTime.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }

    func getDayFor(_ temp: Int) -> String {
        return DateFormatter.wDay.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }
    
    func getDayNumber(_ temp: Int) -> String {
        return DateFormatter.wDateValue.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }

    func getTempFor(_ temp: Double) -> String {
        return String(format: "%1.0f", temp)
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image("sun")
            case "01n":
                return Image("moon")
            case "02d":
                return Image("cloudSun")
            case "02n":
                return Image("cloudMoon")
            case "03d":
                return Image("cloud")
            case "03n":
                return Image("cloudMoon")
            case "04d":
                return Image("cloudMax")
            case "04n":
                return Image("cloudMoon")
            case "09d":
                return Image("rainy")
            case "09n":
                return Image("rainy")
            case "10d":
                return Image("rainySun")
            case "10n":
                return Image("rainyMoon")
            case "11d":
                return Image("thunderstormSun")
            case "11n":
                return Image("thunderstormMoon")
            case "13d":
                return Image("snowy")
            case "13n":
                return Image("snowy-2")
            case "50d":
                return Image("tornado")
            case "50n":
                return Image("tornado")
            default:
                return Image("sun")
        }
    }
}

extension WeatherViewModel {
    private func getLocation(city: String = "Reading") {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                Task {
                    await self.fetchWeatherData(coord: place.location?.coordinate)
                }
            }
        }
    }

    private func fetchWeatherData(coord: CLLocationCoordinate2D?) async {
        let urlSearchParams = WeatherRequestModel(latitude: "\(coord?.latitude ?? 51.4514278)",
                                                  longitude: "\(coord?.longitude ?? -1.078448)",
                                                  excludeFields: "minutely",
                                                  units: "metric")

        // Create an instance of the WeatherService to make the network request.
        let serviceRequest = WeatherService()
        serviceRequest.urlSearchParams = urlSearchParams

        do {
            // Attempt to fetch the APOD media using the service. The `fetch` function returns a `Result` object.
            weather = try await serviceRequest.fetch()

        } catch let error as NSError {
            // If an error occurs during the fetching process, print the error for debugging purposes,
            // stop the loading animation, and show an error prompt to the user.
            debugPrint(error.debugDescription)
        }
    }
}
