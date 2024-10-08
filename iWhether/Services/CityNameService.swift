//
//  CityNameService.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 07/10/24.
//

import Foundation
import Combine

/// Service for interacting with the Weather Forecast API.
///
class CityNameService: ServiceProviding {
    
    // MARK: - Properties
    
    /// Query parameters for the Weather Forecast request.
    var urlSearchParams: WeatherRequestModel?
        
    // MARK: - ServiceProviding Methods
    
    /// Constructs a Request object based on the search parameters.
    /// - Returns: A Request object, or nil if the URL path cannot be constructed.
    func makeRequest() -> Request {
        
        // Base URL for the Media of the Day API endpoint.
        var reqUrlPath = Environment.validateCity
        
        // Append query parameters to the base URL if they exist.
        reqUrlPath = reqUrlPath.replacingOccurrences(of: "{CityID}", with: urlSearchParams?.city ?? "\(Constants.city)")
        
        // Create and return a Request object with the constructed URL path.
        let request = Request(
            path: reqUrlPath,
            method: .get,
            contentType: "application/json",
            headerParams: nil,
            type: .weatherForecast,
            body: nil
        )
        return request
    }
    
    /// Executes a network request and returns the result.
    /// - Parameter completion: A closure to handle the result of the network request.
    /// - Note: This method is generic and can handle any Decodable type.
    func fetch<T>(completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        // Construct the request using makeRequest().
        let request = makeRequest()
        
        // Execute the request using NetworkManager.
        NetworkManager(session: UserSession.activeSession).execute(request: request) { result in
            DispatchQueue.main.async {
                // Call the completion handler with the result of the request.
                completion(result)
            }
        }
    }
    
    /// Executes a network request and returns the result.
    /// - Note: This method is generic and can handle any Decodable type.
    ///
    @MainActor
    func fetch<T>() async throws -> T where T : Decodable {
        
        // Construct the request using makeRequest().
        let request = makeRequest()
        
        // Execute the request using NetworkManager.
        return try await NetworkManager(session: UserSession.activeSession).execute(request: request)
    }
    
    func fetch<T>() -> AnyPublisher<T, NetworkError> where T : Decodable  {
        // Construct the request using makeRequest().
        let request = makeRequest()
        return NetworkManager(session: UserSession.activeSession).execute(request: request)
    }
}
