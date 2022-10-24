import SwiftUI

struct RepositoryView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel = DependencyManager.shared.resolve(RepositoryViewModel.self)
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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

