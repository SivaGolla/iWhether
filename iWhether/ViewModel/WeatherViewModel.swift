//
//  WeatherViewModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import Combine
import CoreLocation
import SwiftUI

/// A view model for managing weather data and forecasts for a specified city.
///
/// This view model fetches and stores weather information, including current conditions, forecasts, and related metrics.
final class WeatherViewModel: ObservableObject {
    /// The current weather response data.
    @Published var weather: WeatherResponse = WeatherResponse()
    
    /// A boolean indicating whether weather data is currently being loaded.
    @Published var loading: Bool = false
    
    /// A set of cancellables for managing Combine subscriptions.
    private var cancellables: Set<AnyCancellable> = []
    
    /// The geographical coordinates of the city.
    private var coordinates: CLLocationCoordinate2D?
    
    /// The name of the city for which to fetch weather data.
    var city = Constants.city {
        didSet {
            ExtractCityCoordinates()
        }
    }
    
    /// Initializes the view model with a specified city.
    ///
    /// - Parameter city: The name of the city for which weather data will be fetched.
    init(city: String) {
        self.city = city
        ExtractCityCoordinates()
    }
}

extension WeatherViewModel {
    /// The weather forecast for today.
    private var todayForecast: WeatherDaily? {
        let date = Date(timeIntervalSince1970: weather.current.date)
        let dateText = date.formatted(date: .numeric, time: .omitted)
        
        return weather.daily.first { Date(timeIntervalSince1970: $0.date).formatted(date: .numeric, time: .omitted) == dateText }
    }
    
    /// A formatted string representing today's date.
    var date: String {
        return DateFormatter.wDefault.string(from: Date(timeIntervalSince1970: weather.current.date))
    }

    /// The weather icon representing current conditions.
    var weatherIcon: String {
        return weather.current.weather.first?.icon ?? "sun"
    }

    /// The formatted current temperature.
    var temperature: String {
        return weather.current.temperature.formattedTemperature
    }
    
    /// The minimum temperature forecast for today.
    var currentMinTemp: String {
        return (todayForecast?.temperature.min ?? 0).formattedTemperature
    }
    
    /// The maximum temperature forecast for today.
    var currentMaxTemp: String {
        return (todayForecast?.temperature.max ?? 0).formattedTemperature
    }

    /// The temperature that feels like based on current conditions.
    var feelsLike: String {
        return (weather.current.feelsLike).formattedTemperature
    }
    
    /// The main weather condition description.
    var conditions: String {
        return weather.current.weather.first?.main ?? "Cloudy"
    }
    
    /// A textual description of the hourly forecast for the current session.
    var hourlyForecastForTheCurrentSession: String {
        let hour = Int(weather.current.date.formattedHour) ?? 0
        
        var dayOrNightText = "tonight"
        var morningOrNight = "morning"
        
        if hour > 6 && hour < 18 {
            dayOrNightText = "today"
            morningOrNight = "night"
        }
        
        let windSpeed = String(format: "%0.0f", weather.current.windSpeed)
        
        return "\(conditions) conditions \(dayOrNightText), continuing through the \(morningOrNight). Wind gusts up to \(windSpeed) mph are making the temperature feel like \(feelsLike)º."
    }

    /// The current wind speed formatted as a string.
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.windSpeed)
    }

    /// The current humidity level formatted as a string.
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }

    /// The chances of rain formatted as a string.
    var rainChances: String {
        return String(format: "%0.1f%%", weather.current.dewPoint)
    }
}

extension WeatherViewModel {
    /// Extracts geographical coordinates for the specified city using geocoding.
    ///
    /// - Parameter city: The name of the city for which to extract coordinates. Defaults to "London".
    private func ExtractCityCoordinates(city: String = "London") {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                self.coordinates = place.location?.coordinate
            }
        }
    }

    /// Fetches the weather data for the current city and updates the `weather` property.
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
        
        // Attempt to fetch the weather data using the service.
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
