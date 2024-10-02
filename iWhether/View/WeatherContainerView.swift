//
//  WeatherContainerView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

struct WeatherContainerView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            CurrentConditionsView(cityName: viewModel.city,
                                  temperature: viewModel.temperature,
                                  feelsLike: viewModel.feelsLike,
                                  minTemp: viewModel.currentMinTemp,
                                  maxTemp: viewModel.currentMaxTemp)
                .padding()
            HourlyForecastView()
                .padding(.horizontal)
            
            DailyForecastView()
                .padding(.horizontal)
        }
    }
}

#Preview {
    WeatherContainerView()
}
