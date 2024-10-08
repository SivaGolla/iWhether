//
//  URLSessionProtocol.swift
//  iWeather
//
//  Created by Venkata Sivannarayana Golla on 02/10/24.
//

import Foundation
import Combine

/// A protocol abstraction for URLSession, allowing for better testability by enabling mocking of network requests.
protocol URLSessionProtocol {
    
    /// Typealias for the completion handler used in data tasks.
    /// - Parameters:
    ///   - data: The data returned by the server.
    ///   - response: The response returned by the server.
    ///   - error: An error object that indicates why the request failed, or nil if the request was successful.
    ///
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    /// Creates a data task with the given request and completion handler.
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    /// - Returns: A URLSessionDataTaskProtocol that can be used to start the request.
    ///
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
      
    /// Creates a data task with the given request and completion handler.
    /// - Parameters:
    ///   - request: The URL object that provides the request details.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    /// - Returns: A URLSessionDataTaskProtocol that can be used to start the request.
    ///
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTaskProtocol
    
    /// Fetches data for the given request
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - delegate: delegate
    /// - Returns: A (Data, URLResponse) tuple that can be used to start the request.
    ///
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
    
    /// Fetches data for the given url end point
    /// - Parameters:
    ///   - url: URL object that provides the end point
    ///   - delegate: delegate
    /// - Returns: A (Data, URLResponse) tuple that can be used to start the request.
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
    
    /// Creates a download task with the given request and completion handler.
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    /// - Returns: A URLSessionDownloadTaskProtocol that can be used to start the request.
    ///
    func downloadTask(with url: URL, completionHandler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void) -> URLSessionDownloadTaskProtocol
    
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    func dataTaskAPublisher(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
    
//    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

/// Extension to conform URLSession to the URLSessionProtocol, enabling the use of URLSession in a testable way.
extension URLSession: URLSessionProtocol {
    
    /// Creates a data task with the given request and completion handler.
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    /// - Returns: A URLSessionDataTaskProtocol that can be used to start the request.
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        // Create a URLSessionDataTask and return it as a URLSessionDataTaskProtocol.
        let dataTask = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
        return dataTask
    }
    
    /// Creates a data task with the given request and completion handler.
    /// - Parameters:
    ///   - request: The URL object that provides the request details.
    ///   - completionHandler: The completion handler to call when the load request is complete.
    /// - Returns: A URLSessionDataTaskProtocol that can be used to start the request.
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTaskProtocol {
        let dataTask = dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
        return dataTask
    }
    
    /// Fetches data for the given request
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - delegate: delegate
    /// - Returns: A (Data, URLResponse) tuple that can be used to start the request.
    ///
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        // Create a URLSessionDataTask and return it as a URLSessionDataTaskProtocol.
        return try await data(for: request) as (Data, URLResponse)
    }
    
    /// Fetches data for the given url
    /// - Parameters:
    ///   - request: The URLRequest object that provides the request details.
    ///   - delegate: delegate
    /// - Returns: A (Data, URLResponse) tuple that can be used to start the request.
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return try await data(from: url)
    }
    
    func downloadTask(with url: URL, completionHandler: @escaping @Sendable (URL?, URLResponse?, (any Error)?) -> Void) -> URLSessionDownloadTaskProtocol {
        return downloadTask(with: url, completionHandler: completionHandler) as URLSessionDownloadTask
    }
    
    func dataTaskAPublisher(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

/// A protocol abstraction for URLSessionDataTask, allowing for better testability.
protocol URLSessionDataTaskProtocol {
    /// Resumes the task, if it is suspended.
    func resume()
}

/// A protocol abstraction for URLSessionDataTask, allowing for better testability.
protocol URLSessionDownloadTaskProtocol {
    /// Resumes the task, if it is suspended.
    func resume()
}

/// Extension to conform URLSessionDataTask to the URLSessionDataTaskProtocol, allowing it to be used within the URLSessionProtocol abstraction.
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

/// Extension to conform URLSessionDataTask to the URLSessionDataTaskProtocol, allowing it to be used within the URLSessionProtocol abstraction.
extension URLSessionDownloadTask: URLSessionDownloadTaskProtocol {}
