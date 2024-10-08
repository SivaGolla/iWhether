//
//  WeatherContainerView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

/// A view that displays the weather information, including current conditions, hourly, and daily forecasts.
///
/// This view organizes the display of various weather components using the WeatherViewModel.
///
struct WeatherContainerView: View {
    
    // ObservedObject that holds the WeatherViewModel instance to manage the weather data.
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            // Displays the current weather conditions.
            CurrentConditionsView(viewModel: viewModel)
                .padding()
            
            // Displays the hourly forecast.
            HourlyForecastView(viewModel: viewModel)
                .padding(.horizontal)
            
            // Displays the daily forecast.
            DailyForecastView(viewModel: viewModel)
                .padding(.horizontal)
        }
    }
}

#Preview {
    WeatherContainerView(viewModel: WeatherViewModel(city: "London"))
}
