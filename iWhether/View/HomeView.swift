//
//  HomeView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedCity: CityButtonView?
    
    var body: some View {
        NavigationSplitView {
            VStack {
                TextField("Search a city...", text: $viewModel.searchQuery, onCommit: {
                    viewModel.performSearch()
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                // End: Textfield
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    
                    // Show List of Cities
                    List(viewModel.cities) { city in
                        NavigationLink(destination: CityWeatherView(viewModel: WeatherViewModel(city: city.cityName))) {
                            Text(city.cityName)
                                .font(.title2)
                                .padding(.all, 8)
                                .cornerRadius(8.0)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.meduimBlueColor.opacity(0.9))
                        .foregroundColor(.white)
                    }
                    .background(Color.meduimBlueColor.opacity(0.9))
                    // End: List View
                }
            }
            .background(Color.meduimBlueColor.opacity(0.85))
            .navigationTitle("Cities")
            
        } detail: {
            if let city = selectedCity {
                CityWeatherView(viewModel: WeatherViewModel(city: city.cityName))
            } else {
                Text("Select a city")
            }
        }
    }
}

#Preview {
    HomeView()
}
