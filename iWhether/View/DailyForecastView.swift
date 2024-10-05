//
//  DailyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct DailyForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Label("5-Day Forecast: ", systemImage: "calendar")
                .font(.footnote)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all, 10)
            
            Divider()
                .frame(minHeight: 1)
                .background(Color.hourViewSeparator)
            
            ForEach(viewModel.weather.daily) { weather in
                LazyVStack {
                    DailyForecastCellView(weather: weather)
                }
            }
        }
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
    DailyForecastView()
}
