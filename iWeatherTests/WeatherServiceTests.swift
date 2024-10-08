//
//  WeatherServiceTests.swift
//  iWeatherTests
//
//  Created by Venkata Sivannarayana Golla on 07/10/24.
//

import XCTest
import Combine
@testable import iWeather_Dev

final class WeatherServiceTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var session: MockURLSession!
    var wService: WeatherService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        session.mDelegate = self
        networkManager = NetworkManager(session: session)
        wService = WeatherService()
    }

    override func tearDownWithError() throws {
        wService = nil
        networkManager = nil
        session.mDelegate = nil
        session = nil
        try super.tearDownWithError()
    }

    func testMakeRequest() {
        // Arrange
        let requestParams = WeatherRequestModel(city: "London",
                                                latitude: "\(Constants.defaultCoordinates.latitude)",
                                                longitude: "\(Constants.defaultCoordinates.longitude)",
                                                excludeFields: "minutely",
                                                units: "metric")
        wService.urlSearchParams = requestParams
        
        // Act
        let request = wService.makeRequest()
        
        // Assert
        XCTAssertNotNil(request)
    }

    func testFetchCompletion() throws {
        // Arrange
        let bundle = Bundle(for: NetworkManager.self)
        guard let mockResponseFileUrl = bundle.url(forResource: "WeatherResponseData", withExtension: "json"),
              let data = try? Data(contentsOf: mockResponseFileUrl) else {
            XCTFail("Expected success, but got failure")
            return
        }
        
        let model = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        
        // Act
        let requestParams = WeatherRequestModel(city: "London",
                                                latitude: "\(Constants.defaultCoordinates.latitude)",
                                                longitude: "\(Constants.defaultCoordinates.longitude)",
                                                excludeFields: "minutely",
                                                units: "metric")
        
        wService.urlSearchParams = requestParams
        
        wService.fetch { (result: Result<WeatherResponse, NetworkError>) in
            // Assert
            switch result {
            case .success(let data):
                XCTAssertEqual(data, model)
            case .failure:
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchAsync() async throws {
        // Arrange Mock Data
        let bundle = Bundle(for: NetworkManager.self)
        guard let mockResponseFileUrl = bundle.url(forResource: "WeatherResponseData", withExtension: "json"),
              let data = try? Data(contentsOf: mockResponseFileUrl) else {
            XCTFail("Expected success, but got failure")
            return
        }
        
        let model = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
        // Act
        let requestParams = WeatherRequestModel(city: "London",
                                                latitude: "\(Constants.defaultCoordinates.latitude)",
                                                longitude: "\(Constants.defaultCoordinates.longitude)",
                                                excludeFields: "minutely",
                                                units: "metric")
        
        wService.urlSearchParams = requestParams
        
        do {
            let result: WeatherResponse = try await wService.fetch()
            XCTAssertEqual(result, model)
        } catch let error as NSError {
            XCTFail("Expected success, but got failure")
        }
    }
    
    func testFetchDataPublisherSuccess() throws {
        
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
        
        let model = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
        let expectation = self.expectation(description: "Fetch data")
        var cancellables: Set<AnyCancellable> = []

        wService.fetch()
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { (result: WeatherResponse) in
                XCTAssertEqual(result, model)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
        
    func testFetchDataFailure() {
        session.mockResponse = HTTPURLResponse(url: URL(string: "https://api.example.com")!,
                                               statusCode: 401,
                                               httpVersion: nil,
                                               headerFields: nil)
        session.mockError = .internalServerError
        UserSession.activeSession = session
        
        let expectation = self.expectation(description: "Fetch data failure")
        
        var cancellables: Set<AnyCancellable> = []
        
        wService.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.badRequest)
                    expectation.fulfill()
                }
            }, receiveValue: { (result: WeatherResponse) in
                
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension WeatherServiceTests: MockURLSessionDelegate {
    func resourceName(for path: String, httpMethod: String) -> String {
        return "WeatherResponseData"
    }
}
