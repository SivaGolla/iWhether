//
//  WeatherService.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation

/// Service for interacting with the Media of the Day API.
///
class WeatherService: ServiceProviding {
    
    // MARK: - Properties
    
    /// Search parameters for the Media of the Day request.
    var urlSearchParams: WeatherRequestModel?
    
    // MARK: - ServiceProviding Methods
    
    /// Constructs a Request object based on the search parameters.
    /// - Returns: A Request object, or nil if the URL path cannot be constructed.
    func makeRequest() -> Request {
        
        // Base URL for the Media of the Day API endpoint.
        var reqUrlPath = Environment.wForecast
        
        // Append query parameters to the base URL if they exist.
        if let requestParams = urlSearchParams {
            
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{latitude}", with: requestParams.latitude)
            
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{longitude}", with: requestParams.longitude)
            
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{excludeFields}", with: requestParams.excludeFields)
            
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{units}", with: requestParams.units)
            
//            let excludeFields = "minutely"
//            metric
            
        } else {
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{latitude}", with: "51.4514278")
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{longitude}", with: "-1.078448")
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{excludeFields}", with: "minutely")
            reqUrlPath = reqUrlPath.replacingOccurrences(of: "{units}", with: "metric")
        }
        
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
}
