//
//  DailyForecastCellView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct DailyForecastCellView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var weather: WeatherDaily
    
    var body: some View {
        HStack {
            HStack {
                Text(viewModel.getDayFor(weather.date).uppercased())
                    .frame(width: 50)
                Text(viewModel.getDayNumber(weather.date))
            }
            Spacer()
            Image(weather.weather[0].icon)
                .resizable()
                .scaledToFill()
                .frame(width: 30,
                       height: 30,
                       alignment: .center)
            Spacer()
            HStack {
                Image("cold")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Text("\(viewModel.getTempFor(weather.temperature.min))°C")
            }
            Spacer()
            HStack {
                Image("warm")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Text("\(viewModel.getTempFor(weather.temperature.max))°C")
            }
        }
        .font(.body)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
//        .background(
//            RoundedRectangle(cornerRadius: Constants.Dimensions.cornerRadius)
//                .fill(
//                    LinearGradient(
//                        gradient: Gradient(colors: Constants.Colors.gradient),
//                        startPoint: .topLeading, endPoint: .bottomTrailing
//                    )
//                )
//        )
//        .shadow(color: Color.white.opacity(0.1),
//                radius: 2,
//                x: -2,
//                y: -2)
//        .shadow(color: Color.black.opacity(0.2),
//                radius: 2,
//                x: 2,
//                y: 2)
    }
}

#Preview {
    DailyForecastCellView(viewModel: WeatherViewModel(), weather: WeatherDaily())
}
