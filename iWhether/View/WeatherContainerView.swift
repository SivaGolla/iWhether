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
            CurrentConditionsView(viewModel: viewModel)
                .padding()
            
            HourlyForecastView(viewModel: viewModel)
                .padding(.horizontal)
            
            DailyForecastView(viewModel: viewModel)
                .padding(.horizontal)
        }
    }
}

#Preview {
    WeatherContainerView(viewModel: WeatherViewModel(city: "London"))
}
