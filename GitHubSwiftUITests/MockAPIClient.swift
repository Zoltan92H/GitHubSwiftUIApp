//
//  MockAPIClient.swift
//  GitHubSwiftUIUITests
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation
import Combine
@testable import GitHubSwiftUI

class MockAPIClient: APIClientProtocol {
    func getCharacters(search: String) -> AnyPublisher<GitHubSwiftUI.Repository, Error> {
        let repository = Repository(items: [RepositoryItem(id: 0, name: "Name", fullName: "FulName", repositoryURL: URL(string: "https://google.com/")!, owner: User(id: 0, login: "Login", avatarURL: URL(string: "https://google.com/")!))])
        let result = Result<Repository, Error>.success(repository).publisher.eraseToAnyPublisher()
        return result
    }
}

