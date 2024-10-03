//
//  ContentView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    WeatherContainerView()
                        .padding(.top, Spacing.defaultPadding)
                        .environmentObject(weatherViewModel)
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top, 2)
            }
            .background(Color.meduimBlueColor)
        }
        .onAppear {
            weatherViewModel.city = Constants.city
        }
    }
}

#Preview {
    ContentView()
}
