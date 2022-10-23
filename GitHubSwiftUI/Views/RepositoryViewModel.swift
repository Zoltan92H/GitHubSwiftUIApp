
import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published var repositories: [RepositoryItem] = []
    @Published var errorMessage: String? = nil
    @Published var search: String = "" {
        didSet {
            if !search.isEmpty {
                getRepositories(searchText: search)
            }
        }
    }
    
    var cancelable: Set<AnyCancellable> = []
    let client: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.client = apiClient
    }
    
    func getRepositories(searchText: String) {
        client.getCharacters(search: searchText)
            .sink(
                receiveCompletion: { _ in
                },
                receiveValue: { [weak self] products in
                    self?.repositories = products.items
                }
            ).store(in: &cancelable)
    }
}
