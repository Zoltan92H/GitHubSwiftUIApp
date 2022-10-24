import SwiftUI

struct RepositoryView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel = DependencyManager.shared.resolve(RepositoryViewModel.self)
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if let error = viewModel.error {
                    Text("\(Localization.fetchErrorText) \(error.localizedDescription)")
                        .padding()
                }
                else {
                    if searchText.isEmpty {
                        Text("\(Localization.enterSearchTermText)")
                    }
                    else if viewModel.repositories.isEmpty {
                        Text("\(Localization.noRepositoryFoundText)")
                    }
                    else {
                        List(viewModel.repositories, id: \.self) { repo in
                            NavigationLink(destination:
                                            WebView(url: repo.repositoryURL)
                                .navigationBarTitle(Text(repo.fullName))
                            ) {
                                RepositoryCell(repoItem: repo)
                            }
                        }.navigationBarTitle(Text("\(Localization.repositories)"))
                    }
                }
            }
        }
        .navigationTitle("\(Localization.searchRepositories)")
        .searchable(text: $searchText)
        .onChange(of: searchText, perform: viewModel.getRepositories(searchText:))
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}

