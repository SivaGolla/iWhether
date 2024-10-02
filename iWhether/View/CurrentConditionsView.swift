//
//  CurrentConditionsView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

struct CurrentConditionsView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(viewModel.city)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text("\(viewModel.temperature)°")
                .font(.system(size: 80))
                .foregroundColor(.white)
            
            Text("Feels Like: \(viewModel.feelsLike)°")
                .font(.title3)
                .foregroundColor(.gray)
            
            HStack(spacing: 16) {
                Text("H: \(viewModel.currentMaxTemp)°")
                    .font(.title2)
                    .foregroundColor(.secondaryText)
                
                Text("L: \(viewModel.currentMinTemp)°")
                    .font(.title2)
                    .foregroundColor(Color.secondaryText)
            }
        }
        .padding()
    }
}

#Preview {
    CurrentConditionsView()
}
