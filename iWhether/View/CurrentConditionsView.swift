//
//  CurrentConditionsView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

struct CurrentConditionsView: View {
    var cityName: String
    var temperature: String
    var feelsLike: String
    var minTemp: Double
    var maxTemp: Double
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(cityName)
                .font(.largeTitle)
                .bold()
            
            Text("\(temperature)°")
                .font(.system(size: 70))
                .bold()
            
            Text("Feels Like: \(feelsLike)")
                .font(.title)
                .foregroundColor(.gray)
            
            HStack(spacing: 16) {
                Text("\(minTemp)°")
                    .font(.title)
                    .foregroundColor(.gray)
                
                Text("\(maxTemp)°")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
    }
}

#Preview {
    CurrentConditionsView(cityName: "Reading", temperature: "13.0", feelsLike: "8.0", minTemp: 5.0, maxTemp: 15.0)
}
