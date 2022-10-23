//
//  DependencyManager.swift
//  SampleCombineNetworking
//
//  Created by Zoltán Hidegkuti on 2022. 10. 23..
//

import Foundation

protocol DependencyManagerProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(_ type: Component.Type) -> Component
}

final class DependencyManager: DependencyManagerProtocol {
    // MARK: - Private variables
    
    static let shared = DependencyManager()
    var components: [String: Any] = [:]
    
    private init() {}
    
    // MARK: - Public methods
    
    static func setup() {
        // Registering components
        registerServices()
        registerModels()
        registerViewModels()
        
        // Initializing registered components
        initServices()
        initModels()
        initViewModels()
    }
    
    func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }
    
    func resolve<Component>(_ type: Component.Type) -> Component {
        return (components["\(type)"] as? Component)!
    }
    
    // MARK: - Private methods
    
    static private func registerServices() {
        
    }
    
    static private func initServices() {
        // If there are any services to start, it should be here
    }
    
    static private func registerModels() {
        
    }
    
    static private func initModels() {
        // If there are any models to init, it should be here
    }
    
    static private func registerViewModels() {
        shared.register(type: RepositoryViewModel.self, component: RepositoryViewModel())
    }
    
    static private func initViewModels() {
    }
}
