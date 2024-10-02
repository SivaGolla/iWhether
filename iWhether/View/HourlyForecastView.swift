//
//  HourlyForecastView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct HourlyForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.weather.hourly) { weather in
                    let icon = Image((weather.weather.first?.icon ?? "sun").wIconName)
                    let hour = viewModel.getTimeFor(weather.date)
                    let temp = viewModel.getTempFor(weather.temperature)
                    
                    HourlyCellView(hour: hour, image: icon, temp: temp)
                }
            }
        }
        .background(Color.hourCellBg)
        .cornerRadius(8.0)
    }
}

#Preview {
    HourlyForecastView()
}
