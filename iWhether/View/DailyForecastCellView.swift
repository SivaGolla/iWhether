//
//  DailyForecastCellView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct DailyForecastCellView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    var weather: WeatherDaily
    
    var body: some View {
        HStack {
            HStack {
                Text(weather.date.formattedDay.uppercased())
                    .frame(width: 50)
                Text(weather.date.formattedDayValue)
            }
            Spacer()
            Image(viewModel.weatherIconNameFor(weather: weather))
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
            Spacer()
            HStack {
                Image("cold")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Text("\(weather.temperature.min.formattedTemperature)°C")
            }
            Spacer()
            HStack {
                Image("warm")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Text("\(weather.temperature.max.formattedTemperature)°C")
            }
        }
        .font(.body)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: Color.gradient),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(color: Color.white.opacity(0.1),
                radius: 2,
                x: -2,
                y: -2)
        .shadow(color: Color.black.opacity(0.2),
                radius: 2,
                x: 2,
                y: 2)
    }
}

#Preview {
    DailyForecastCellView(weather: WeatherDaily())
}
