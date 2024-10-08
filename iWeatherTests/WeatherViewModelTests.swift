//
//  WeatherViewModelTests.swift
//  iWeatherTests
//
//  Created by Venkata Sivannarayana Golla on 07/10/24.
//

import XCTest
import Combine
import CoreLocation
@testable import iWeather_Dev

final class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var cancellables: Set<AnyCancellable>!
    var session: MockURLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = WeatherViewModel(city: "London")
        cancellables = []
        session = MockURLSession()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.city, "London", "Initial city should be London.")
        XCTAssertEqual(viewModel.weather.current.date, 0, "Initial date should be zero.")
        XCTAssertFalse(viewModel.loading, "Loading state should be false initially.")
    }

    func testFetchWeatherData() {
        // Assuming you have a mock or a way to simulate the WeatherService response
        
        let bundle = Bundle(for: NetworkManager.self)
        guard let mockResponseFileUrl = bundle.url(forResource: "WeatherResponseData", withExtension: "json"),
              let data = try? Data(contentsOf: mockResponseFileUrl) else {
            XCTFail("Expected success, but got failure")
            return
        }
        session.mockData = data
        session.mockResponse = HTTPURLResponse(url: URL(string: "https://api.example.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        UserSession.activeSession = session
        
        let expectation = self.expectation(description: "Weather data should be fetched.")

        // Act
        viewModel.fetchWeatherData()
        
        // Simulate a delay for network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Assert
            XCTAssertFalse(self.viewModel.loading, "Loading state should be false after fetching data.")
            XCTAssertNotNil(self.viewModel.weather.current.date, "Weather data should not be nil after fetching.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testWeatherProperties() {
        // Arrange: Set a mock WeatherResponse
        var mockWeatherResponse = WeatherResponse()
        mockWeatherResponse.current = Weather(date: Date().timeIntervalSince1970,
                                              temperature: 20.0,
                                              feelsLike: 18.0,
                                              pressure: 5,
                                              humidity: 80,
                                              dewPoint: 15.0,
                                              clouds: 88,
                                              windSpeed: 10.0,
                                              windDeg: 0,
                                              weather: [WeatherDetail(main: "Rain", description: "Rain", icon: "10d")])
        
        viewModel.weather = mockWeatherResponse
        
        // Act & Assert
        XCTAssertEqual(viewModel.date, DateFormatter.wDefault.string(from: Date()), "Date should match today's date.")
        XCTAssertEqual(viewModel.weatherIcon, "10d", "Weather icon should match the mock data.")
        XCTAssertEqual(viewModel.temperature, "20", "Temperature should be 20.0º.")
        XCTAssertEqual(viewModel.currentMinTemp, "0", "Current min temperature should be 0.0º.")
        XCTAssertEqual(viewModel.currentMaxTemp, "0", "Current max temperature should be 0.0º.")
        XCTAssertEqual(viewModel.feelsLike, "18", "Feels like temperature should be 18.0º.")
        XCTAssertEqual(viewModel.conditions, "Rain", "Conditions should be Rain.")
        XCTAssertEqual(viewModel.windSpeed, "10.0", "Wind speed should be 10.0 mph.")
        XCTAssertEqual(viewModel.humidity, "80%", "Humidity should be 80%.")
        XCTAssertEqual(viewModel.rainChances, "15.0%", "Rain chances should be 15.0%.")
    }
}
