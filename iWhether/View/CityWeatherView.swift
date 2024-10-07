//
//  CityWeatherView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import SwiftUI

struct CityWeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                if viewModel.loading {
                    ProgressView()
                }
                
                ScrollView(showsIndicators: false) {
                    WeatherContainerView(viewModel: viewModel)
                        .padding(.top, Spacing.defaultPadding)
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
