
import SwiftUI

struct RepositoryView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel = DependencyManager.shared.resolve(RepositoryViewModel.self)
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Searching for \(viewModel.search)")
                        .searchable(text: $viewModel.search)
                    
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
        .onAppear(perform: { self.viewModel.getRepositories(searchText: "") })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}

