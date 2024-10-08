//
//  CityWeatherView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import SwiftUI

/// A view that displays the weather information for a selected city.
///
/// This view uses a WeatherViewModel to fetch and manage the weather data.
///
struct CityWeatherView: View {
    
    // ObservedObject that holds the WeatherViewModel instance to manage the weather data.
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                
                // Show a loading indicator while data is being fetched.
                if viewModel.loading {
                    ProgressView()
                }
                
                // Scrollable view for weather details.
                ScrollView(showsIndicators: false) {
                    
                    // Weather container that displays the weather information.
                    WeatherContainerView(viewModel: viewModel)
                        .padding(.vertical, Spacing.defaultPadding)
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top, 2)
                
            }
            .background(Color.meduimBlueColor)
        }
        .background(Color.meduimBlueColor)
        .onAppear {
            viewModel.fetchWeatherData()
        }
    }
}

#Preview {
    CityWeatherView(viewModel: WeatherViewModel(city: "London"))
}
