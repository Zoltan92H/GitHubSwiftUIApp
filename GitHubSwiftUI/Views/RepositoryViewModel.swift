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
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self.error = error
                }
            } receiveValue: { [weak self] products in
                self?.repositories = products.items
            }
            .store(in: &cancelable)
    }
}
