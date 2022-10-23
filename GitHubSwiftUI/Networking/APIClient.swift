//
//  APIClient.swift
//  SampleCombineNetworking
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation
import Combine

protocol APIClientProtocol {
    func getCharacters(search: String) -> AnyPublisher<Repository, Error>
}

public final class APIClient: APIClientProtocol {
    let httpClient: HTTPClient = HTTPClient()
    
    public let configuration = APIConfiguration(
        baseURL: "https://api.github.com",
        decoder: .init()
    )
}

public extension APIClient {
    func getCharacters(search: String) -> AnyPublisher<Repository, Error> {
        return send(request: getCharactersRequest(search: search))
    }
}

public extension APIClient {
    func send<Output>(request: APIRequest) -> AnyPublisher<Output, Error> where Output: Decodable {
        request
            .prepare(with: configuration)
            .map(httpClient.fetch(request:))
            .flatMap(validate(response:))
            .receive(on: DispatchQueue.main)
            .decode(type: Output.self, decoder: configuration.decoder)
            .eraseToAnyPublisher()
    }
    
    func getCharactersRequest(search: String) -> APIRequest {
        return .init(
            path: "/search/repositories",
            method: .get,
            headers: [:],
            queryItems: ["q": search],
            body: nil
        )
    }
    
    func validate(response: AnyPublisher<HTTPResponse, Error>) -> AnyPublisher<Data, Error> {
        response
            .tryMap { response in
                switch response.statusCode {
                case 200..<300:
                    return response.data
                case 300..<400:
                    return response.data
                case 400..<500:
                    return response.data
                case 500..<600:
                    do {
                        throw APIError.serverError(try JSONDecoder().decode(APIErrorResponse.self, from: response.data))
                    }
                    catch {
                        throw APIError.invalidErrorResponse(error)
                    }
                default:
                    throw APIError.unexpectedStatusCode
                }
            }
            .eraseToAnyPublisher()
    }
}
