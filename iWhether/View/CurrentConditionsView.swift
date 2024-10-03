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
        VStack(alignment: .center, spacing: 0) {
            Text(viewModel.city)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("\(viewModel.temperature)°")
                .frame(maxHeight: .infinity) // Allow the text to expand vertically
                .font(.system(size: 100, weight: .thin)) // Set a large font size
                .minimumScaleFactor(0.01) // Allow text to scale down to fit the frame
                .lineLimit(1) // Ensure the text stays on one line
                .foregroundColor(.white)
            
            VStack(spacing: -5) {
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
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    CurrentConditionsView()
}
