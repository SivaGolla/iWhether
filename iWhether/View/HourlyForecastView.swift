//
//  HourlyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct HourlyForecastView: View {
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
            
            // Horizontal scrollable hourly view
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.weather.hourly) { weather in
                        let icon = Image((weather.weather.first?.icon ?? "sun").wIconName)
                        let hour = weather.date.formattedHour
                        let temp = weather.temperature.formattedTemperature
                        
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
