//
//  WeatherContainerView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

struct WeatherContainerView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            CurrentConditionsView(cityName: "", temperature: 13.0, feelsLike: 8.0, condition: "Cloudy")
                .padding()
//            HourlyView(weatherViewModel: weatherViewModel)
//                .padding(.horizontal)
//            DailyWeatherView(weatherViewModel: weatherViewModel)
//                .padding(.horizontal)
        }
    }
}

#Preview {
    WeatherContainerView(viewModel: WeatherViewModel())
}
