//
//  HomeViewModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import Combine
import CoreLocation
import SwiftUI

/// A view model for managing a list of cities, enabling search functionality and data persistence.
///
/// This view model provides the capability to load, save, and validate cities based on user input.
/// It also manages the loading state during city validation and retrieval processes.
class HomeViewModel: ObservableObject {
    /// An array of `CityButtonView` objects representing the list of cities.
    @Published var cities: [CityButtonView] = []
    
    /// A string representing the user's search query for cities.
    @Published var searchQuery = ""
    
    /// A boolean indicating whether data is currently being loaded.
    @State var isLoading = false // Loading state

    private var cancellable: AnyCancellable?
    
    /// Initializes the view model by loading previously saved cities.
    init() {
        loadCities()
        //setupSearch() // Uncomment to enable search functionality
    }
    
    /// Loads cities from UserDefaults and decodes them into the `cities` array.
    private func loadCities() {
        if let data = UserDefaults.standard.data(forKey: "cities") {
            let decoder = JSONDecoder()
            if let savedCities = try? decoder.decode([CityButtonView].self, from: data) {
                cities = savedCities
            }
        }
    }
    
    /// Saves the current list of cities to UserDefaults by encoding them.
    private func saveCities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities) {
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
    }
    
    /// Validates and adds a city to the list if it exists.
    ///
    /// - Parameter city: The name of the city to be validated and added.
    private func addCityIfValid(_ city: String) {
        Task {
            if let placemarks = try? await CLGeocoder().geocodeAddressString(city), !placemarks.isEmpty {
                print(city)
                
                await MainActor.run {
                    cities.append(CityButtonView(id: UUID(), cityName: city))
                    saveCities()
                    
                    loadCities() // Refresh cities after addition
                    isLoading = false
                }
                return
            }
            print("Invalid City: \(city)")
        }
    }
    
    /// Sets up the search functionality by observing changes to the search query.
    private func setupSearch() {
        cancellable = $searchQuery
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { searchText in
                if searchText.isEmpty {
                    return
                }
                
                self.addCityIfValid(searchText)
            }
    }
    
    /// Performs a search for a city based on the current search query.
    ///
    /// The search is considered valid if the query contains at least 3 characters and only consists of letters and spaces.
    func performSearch() {
        if searchQuery.isEmpty || searchQuery.count < 3 {
            return
        }
        
        isLoading = true
        let trimmedName = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        let characterSet = CharacterSet.letters.union(.whitespaces)
            
        let validCity = !trimmedName.isEmpty && trimmedName.rangeOfCharacter(from: characterSet.inverted) == nil
        
        // Optionally, can check if it's a real city by calling an API from OpenWeatherAPI.
        if validCity {
            addCityIfValid(searchQuery)
        }
    }
}
