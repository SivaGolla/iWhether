//
//  WeatherViewModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse = WeatherResponse()
    @Published var loading: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    private var coordinates: CLLocationCoordinate2D?
    var city = Constants.city {
        didSet {
            ExtractCityCoordinates()
        }
    }
    
    init(city: String) {
        self.city = city
        ExtractCityCoordinates()
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
        return weather.current.temperature.formattedTemperature
    }
    
    var currentMinTemp: String {
        return (todayForecast?.temperature.min ?? 0).formattedTemperature
    }
    
    var currentMaxTemp: String {
        return (todayForecast?.temperature.max ?? 0).formattedTemperature
    }

    var feelsLike: String {
        return (weather.current.feelsLike).formattedTemperature
    }
    
    var conditions: String {
        return weather.current.weather.first?.main ?? "Cloudy"
    }
    
    var hourlyForecastForTheCurrentSession: String {
        let hour = Int(weather.current.date.formattedHour) ?? 0
        
        var dayOrNightText = "tonight"
        var morningOrNight = "morning"
        if hour > 6 && hour < 18 {
            dayOrNightText = "today"
            morningOrNight = "night"
        }
        
        let windSpeed = String(format: "%0.0f", weather.current.windSpeed)
        
        return "\(conditions) conditions \(dayOrNightText), continuing through the \(morningOrNight). Wind guts up to \(windSpeed) mph are making the temparature feel like \(feelsLike)º."
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

    func weatherIconNameFor(weather: WeatherDaily) -> String {
        return (weather.weather.first?.icon ?? "sun").wIconName
    }
}

extension WeatherViewModel {
    private func ExtractCityCoordinates(city: String = "London") {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                self.coordinates = place.location?.coordinate
            }
        }
    }

    func fetchWeatherData() {
        let urlSearchParams = WeatherRequestModel(city: city,
                                                  latitude: "\(coordinates?.latitude ?? Constants.defaultCoordinates.latitude)",
                                                  longitude: "\(coordinates?.longitude ?? Constants.defaultCoordinates.longitude)",
                                                  excludeFields: "minutely",
                                                  units: "metric")
        
        // Create an instance of the WeatherService to make the network request.
        let serviceRequest = WeatherService()
        serviceRequest.urlSearchParams = urlSearchParams
        
        loading = true
        
        // Attempt to fetch the Weather data using the service. The `fetch` function returns a `Result` object.
        serviceRequest.fetch()
            .sink { [weak self] completion in
                
                self?.loading = false
                
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            } receiveValue: { [weak self] result in
                self?.weather = result
            }.store(in: &cancellables)
    }
}
