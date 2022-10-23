//
//  GitHubSwiftUIApp.swift
//  GitHubSwiftUI
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import SwiftUI

@main
struct GitHubSwiftUIApp: App {
    
    @StateObject private var vm = DependencyManager.shared.resolve(RepositoryViewModel.self)
    
    init() {
        DependencyManager.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RepositoryView()
            }
            .environmentObject(vm)
        }
    }
}
