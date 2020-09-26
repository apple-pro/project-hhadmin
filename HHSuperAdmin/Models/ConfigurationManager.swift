//
//  ConfigurationManager.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

class ConfigurationManager: ObservableObject {
    
    static let shared = ConfigurationManager()
    
    private let kName = "config.name"
    private let kEndpoint = "config.apiEndpoint"
    
    @Published var name: String?
    @Published var apiEndpoint: String?
    
    private init() {
        apiEndpoint = Config.get(kEndpoint)
        name = Config.get(kName)
    }
    
    var isNotConfigured: Bool {
        name?.isEmpty ?? true || apiEndpoint?.isEmpty ?? true
    }
    
    func configure(withName name: String, andAPI apiEndpoint: String) {
        self.name = name
        self.apiEndpoint = apiEndpoint
        
        Config.set(key: kName, name)
        Config.set(key: kEndpoint, apiEndpoint)
    }
    
}
