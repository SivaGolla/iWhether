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
    var city = Constants.city {
        didSet {
            getLocation()
        }
    }
}

extension WeatherViewModel {
    private var todayForecast: WeatherDaily? {
        let date = weather.current.date
        return weather.daily.first { $0.date == date }
    }
    
    var date: String {
        return DateFormatter.wDefault.string(from: Date(timeIntervalSince1970: weather.current.date))
    }

    var weatherIcon: String {
        return weather.current.weather.first?.icon ?? "sun"
    }

    var temperature: String {
        return getTempFor(weather.current.temperature)
    }
    
    var currentMinTemp: String {
        return getTempFor(todayForecast?.temperature.min ?? 0)
    }
    
    var currentMaxTemp: String {
        return getTempFor(todayForecast?.temperature.max ?? 0)
    }

    var feelsLike: String {
        return getTempFor(weather.current.feelsLike)
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

    func getTimeFor(_ temp: Double) -> String {
        return DateFormatter.wTime.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }

    func getDayFor(_ temp: Double) -> String {
        return DateFormatter.wDay.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }
    
    func getDayNumber(_ temp: Double) -> String {
        return DateFormatter.wDateValue.string(from: Date(timeIntervalSince1970: TimeInterval(temp)))
    }

    func getTempFor(_ temp: Double) -> String {
        return String(format: "%1.0f", temp)
    }
    
    func weatherIconNameFor(weather: WeatherDaily) -> String {
        return (weather.weather.first?.icon ?? "sun").wIconName
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
