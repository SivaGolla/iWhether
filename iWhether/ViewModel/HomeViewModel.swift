//
//  HomeViewModel.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 06/10/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var cities: [CityButtonView] = []
    @Published var searchQuery = ""
    @State var isLoading = false // Loading state

    private var cancellable: AnyCancellable?
    init() {
        loadCities()
        //setupSearch()
    }
    
    private func loadCities() {
        if let data = UserDefaults.standard.data(forKey: "cities") {
            let decoder = JSONDecoder()
            if let savedCities = try? decoder.decode([CityButtonView].self, from: data) {
                cities = savedCities
            }
        }
    }
    
    private func saveCities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities) {
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
    }
    
    private func addCityIfValid(_ city: String) {
        Task {
            if let placemarks = try? await CLGeocoder().geocodeAddressString(city), !placemarks.isEmpty {
                print(city)
                
                await MainActor.run {
                    cities.append(CityButtonView(id: UUID(), cityName: city))
                    saveCities()
                    
                    loadCities()
                    isLoading = false
                }
                return
            }
            print("Invalid City: \(city)")
        }
    }
    
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
    
    func performSearch() {
        if searchQuery.isEmpty || searchQuery.count < 3 {
            return
        }
        
        isLoading = true
        let trimmedName = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        let characterSet = CharacterSet.letters.union(.whitespaces)
            
        let validCity = !trimmedName.isEmpty && trimmedName.rangeOfCharacter(from: characterSet.inverted) == nil
        
        // Alternatively can check if its real city by calling an api from openweatherapi
        if validCity {
            addCityIfValid(searchQuery)
        }
    }
}
