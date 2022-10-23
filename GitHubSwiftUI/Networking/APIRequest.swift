//
//  APIRequest.swift
//  SampleCombineNetworking
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation
import Combine

public struct APIRequest {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let queryItems: [String: String]?
    let body: Data?
}

public extension APIRequest {
    func prepare(with configuration: APIConfiguration) -> AnyPublisher<URLRequest, Error> {
        guard var components = URLComponents(string: configuration.baseURL) else {
            return Fail(error: APIError.invalidBaseURL).eraseToAnyPublisher()
        }
        
        components.path = self.path
        components.queryItems = self.queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = components.url else { return Fail(error: APIError.invalidURL).eraseToAnyPublisher() }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.httpBody = self.body
        
        self.headers.forEach { (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return Just(urlRequest)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

public struct APIConfiguration {
    public let baseURL: String
    public let decoder: JSONDecoder
}

public struct APIErrorResponse: Decodable {
    public let code: String
    public let message: String
}

public enum APIError: Error {
    case invalidBaseURL
    case invalidURL
    case invalidResponse
    case clientError(APIErrorResponse)
    case serverError(APIErrorResponse)
    case invalidErrorResponse(Error)
    case unexpectedStatusCode
}
