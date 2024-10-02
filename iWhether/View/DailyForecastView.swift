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
        ForEach(viewModel.weather.daily) { weather in
            LazyVStack {
                DailyForecastCellView(viewModel: viewModel, weather: weather)
            }
        }
    }
}

#Preview {
    DailyForecastView()
}
