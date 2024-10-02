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
            CurrentConditionsView(cityName: viewModel.city,
                                  temperature: viewModel.date,
                                  feelsLike: viewModel.feelsLike,
                                  minTemp: viewModel.currentMinTemp ?? 0,
                                  maxTemp: viewModel.currentMaxTemp ?? 0)
                .padding()
            HourlyForecastView(viewModel: viewModel)
                .padding(.horizontal)
            
//            DailyWeatherView(weatherViewModel: weatherViewModel)
//                .padding(.horizontal)
        }
    }
}

#Preview {
    WeatherContainerView(viewModel: WeatherViewModel())
}
