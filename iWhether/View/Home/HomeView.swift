//
//  HomeView.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import SwiftUI
import Combine

/// A view that displays a list of cities and allows the user to search for a city.
///
/// This view utilizes a ViewModel to manage city data and search functionality.
///
struct HomeView: View {
    
    // StateObject that holds the HomeViewModel instance to manage the data and logic.
    @StateObject private var viewModel = HomeViewModel()
    
    // State to keep track of the selected city for detailed weather view.
    @State private var selectedCity: CityButtonView?
    
    var body: some View {
        
        // NavigationSplitView allows for a master-detail interface.
        NavigationSplitView {
            VStack {
                
                // TextField for searching cities; triggers performSearch on commit.
                TextField("Search a city...", text: $viewModel.searchQuery, onCommit: {
                    viewModel.performSearch()
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                // End: Textfield
                
                // Show a loading indicator if data is being fetched.
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
            
            // Detail view for selected city, shows CityWeatherView or a placeholder text.
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
