//
//  GitHubSwiftUITests.swift
//  GitHubSwiftUITests
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import XCTest
import Combine
@testable import GitHubSwiftUI

final class GitHubSwiftUITests: XCTestCase {
    
    var viewModel: RepositoryViewModel!
    
    override func setUpWithError() throws {
        viewModel = RepositoryViewModel(apiClient: MockAPIClient())
    }
    
    override func tearDownWithError() throws {
        //viewModel = nil
    }
    
    func test_getRepositoriesData() throws {
        
        // Given an empty viewModel
        XCTAssertTrue(viewModel.repositories.isEmpty)
        
        // When getRepositories is called on MockAPIClient
        viewModel.getRepositories(searchText: "a")
        
        //Then repositories should have 1 repository
        XCTAssertEqual(viewModel.repositories.count, 1)
        XCTAssertFalse(viewModel.repositories.isEmpty)
        XCTAssertEqual(viewModel.repositories.first?.name, "Name")
    }
}
