//
//  DailyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct DailyForecastView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Label("5-Day Forecast: ", systemImage: "calendar")
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
            
            ForEach(viewModel.weather.daily) { weather in
                LazyVStack {
                    DailyForecastCellView(viewModel: viewModel, weather: weather)
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
