import SwiftUI

struct RepositoryView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel = DependencyManager.shared.resolve(RepositoryViewModel.self)
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if let error = viewModel.error {
                    Text("Failed fetching repositories with error \(error.localizedDescription)")
                        .padding()
                }
                else {
                    if searchText.isEmpty {
                        Text("Enter a search term")
                    }
                    else if viewModel.repositories.isEmpty {
                        Text("No repositories found")
                    }
                    else {
                        List(viewModel.repositories, id: \.self) { repo in
                            NavigationLink(destination:
                                            WebView(url: repo.repositoryURL)
                                .navigationBarTitle(Text(repo.fullName))
                            ) {
                                RepositoryCell(repoItem: repo)
                            }
                        }.navigationBarTitle(Text("Repositories"))
                    }
                }
            }
        }
        .navigationTitle("Search Repositories")
        .searchable(text: $searchText)
        .onChange(of: searchText, perform: viewModel.getRepositories(searchText:))
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}

