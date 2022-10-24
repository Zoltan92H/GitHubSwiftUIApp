import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published var repositories: [RepositoryItem] = []
    @Published public var error: Error?
    
    var cancelable: Set<AnyCancellable> = []
    let client: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.client = apiClient
    }
    
    func getRepositories(searchText: String) {
        guard !searchText.isEmpty else {
            repositories = []
            return
        }
        
        client.getCharacters(search: searchText)
            
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self.error = error
                }
            } receiveValue: { [weak self] repositories in
                self?.repositories = repositories.items
            }
            .store(in: &cancelable)
    }
}
