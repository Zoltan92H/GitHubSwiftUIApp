//
//  HTTP Client.swift
//  SampleCombineNetworking
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation
import Combine

public typealias HTTPRequest = URLRequest

public struct HTTPResponse {
  public let data: Data
  public let statusCode: Int
}

public enum HTTPError: Error {
  case invalidHTTPURLResponse
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case trace = "TRACE"
  case option = "OPTION"
  case head = "HEAD"
}

public final class HTTPClient {
  let session: URLSession
  
  public init(session: URLSession = .shared) {
    self.session = session
  }
}

public extension HTTPClient {
  func fetch(request: HTTPRequest) -> AnyPublisher<HTTPResponse, Error> {
    session
      .dataTaskPublisher(for: request)
      .tryMap(response(from:))
      .eraseToAnyPublisher()
  }
}

public extension HTTPClient {
  func response(from dataTaskResponse: (data: Data, response: URLResponse)) throws -> HTTPResponse {
    switch (dataTaskResponse.response as? HTTPURLResponse) {
    case .none:
      throw HTTPError.invalidHTTPURLResponse
    case .some(let httpResponse):
      return HTTPResponse(data: dataTaskResponse.data, statusCode: httpResponse.statusCode)
    }
  }
}
