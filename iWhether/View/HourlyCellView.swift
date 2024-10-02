//
//  HourlyCellView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import SwiftUI

struct HourlyCellView: View {
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
//        .background(
//            RoundedRectangle(cornerRadius: Constants.Dimensions.cornerRadius)
//                .fill(
//                    LinearGradient(
//                        gradient: Gradient(colors: Constants.Colors.gradient),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
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
    HourlyCellView(hour: "00", image: Image(""), temp: "")
}
