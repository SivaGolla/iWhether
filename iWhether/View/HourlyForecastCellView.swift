//
//  HourlyForecastCellView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct HourlyForecastCellView: View {
    var hour: String, image: Image, temp: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(hour)
            image
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
            Text("\(temp)°C")
        }
        .font(.body)
        .foregroundStyle(.white)
        .padding()
    }
}

#Preview {
    HourlyForecastCellView(hour: "00", image: Image(""), temp: "")
}
