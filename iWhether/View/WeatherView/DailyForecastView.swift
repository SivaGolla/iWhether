//
//  DailyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

/// A view that displays the daily weather forecast.
///
/// This view provides an 8-day weather forecast using the data from the WeatherViewModel.
///
struct DailyForecastView: View {
    
    // The view model containing the weather data for the view.
    @ObservedObject var viewModel: WeatherViewModel
    
    // Title for the forecast section
    var body: some View {
        VStack {
            Label("8-Day Forecast: ", systemImage: "calendar")
                .font(.footnote)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            
            VStack {
                Divider()
                    .frame(minHeight: 1)
                    .background(Color.hourViewSeparator)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // For each day's forecast, create a cell view
            ForEach(viewModel.weather.daily) { weather in
                LazyVStack {
                    DailyForecastCellView(weather: weather)
                }
            }
        }
        .padding(.top, 10)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: Color.gradient),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
        )
    }
}

#Preview {
    DailyForecastView(viewModel: WeatherViewModel(city: "London"))
}
