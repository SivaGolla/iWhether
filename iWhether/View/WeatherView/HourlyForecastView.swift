//
//  HourlyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

/// A view that displays the hourly weather forecast.
///
/// This view shows a summary of today's weather along with hourly weather data in a horizontal scrollable format.
///
struct HourlyForecastView: View {
    // ObservedObject that holds the WeatherViewModel instance to manage the hourly weather data.
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            // Today's weather summary
            Text(viewModel.hourlyForecastForTheCurrentSession)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white.opacity(0.9))
                .padding(.all, 16)
                
            VStack {
                Divider()
                    .frame(minHeight: 1)
                    .overlay(Color.gray)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // Horizontal scrollable view for hourly weather
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.weather.hourly) { weather in
                        
                        // Populates weather icon, hour, and temperature for display
                        let icon = Image((weather.weather.first?.icon ?? "sun").wIconName)
                        let hour = weather.date.formattedHour
                        let temp = weather.temperature.formattedTemperature
                        
                        // Creates an hourly forecast cell view for each hour's data
                        HourlyForecastCellView(hour: hour, image: icon, temp: temp)
                    }
                }
            }
        }
        .background(Color.hourCellBg)
        .cornerRadius(8.0)
    }
}

#Preview {
    HourlyForecastView(viewModel: WeatherViewModel(city: "London"))
}
