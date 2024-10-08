//
//  HomeViewModelTests.swift
//  iWeatherTests
//
//  Created by Venkata Sivannarayana Golla on 01/10/24.
//

import XCTest
import Combine
@testable import iWeather_Dev

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Clear UserDefaults before each test
        UserDefaults.standard.removeObject(forKey: "cities")
        
        viewModel = HomeViewModel()
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.cities.count, 0, "Initial cities array should be empty.")
        XCTAssertEqual(viewModel.searchQuery, "", "Initial search query should be empty.")
        XCTAssertFalse(viewModel.isLoading, "Loading state should be false initially.")
    }

    func testLoadCities() {
        // Arrange
        let citiesToSave = [CityButtonView(id: UUID(), cityName: "New York"),
                             CityButtonView(id: UUID(), cityName: "San Francisco")]
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(citiesToSave) {
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
        
        // Act:
        viewModel = HomeViewModel()
        
        // Assert
        XCTAssertEqual(viewModel.cities.count, 2, "Cities array should contain 2 items after loading.")
        XCTAssertEqual(viewModel.cities[0].cityName, "New York", "First city should be New York.")
        XCTAssertEqual(viewModel.cities[1].cityName, "San Francisco", "Second city should be San Francisco.")
    }

    func testPerformSearchWithValidCity() {
        // Arrange
        viewModel.searchQuery = "Chicago"
        
        // Act
        viewModel.performSearch()
        
        // Simulate waiting for async tasks to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Assert
            XCTAssertEqual(self.viewModel.cities.count, 1, "Cities array should contain 1 item after searching for a valid city.")
            XCTAssertEqual(self.viewModel.cities[0].cityName, "Chicago", "The added city should be Chicago.")
        }
    }
    
    func testPerformSearchWithInvalidCity() {
        // Arrange
        viewModel.searchQuery = "Invalid City123"
        
        // Act
        viewModel.performSearch()
        
        // Simulate waiting for async tasks to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Assert
            XCTAssertEqual(self.viewModel.cities.count, 0, "Cities array should be empty after searching for an invalid city.")
        }
    }

    func testPerformSearchWithShortQuery() {
        // Arrange
        viewModel.searchQuery = "NY"
        
        // Act
        viewModel.performSearch()
        
        // Assert
        XCTAssertEqual(viewModel.cities.count, 0, "Cities array should be empty for search queries shorter than 3 characters.")
    }
}
