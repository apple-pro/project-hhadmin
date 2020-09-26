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
    
    var isNotConfigured: Bool {
        name?.isEmpty ?? true
    }
    
    private init() {
        apiEndpoint = UserDefaults.standard.string(forKey: kEndpoint)
        name = UserDefaults.standard.string(forKey: kName)
    }
    
    func configure(withName name: String, andAPI apiEndpoint: String) {
        self.name = name
        self.apiEndpoint = apiEndpoint
        
        UserDefaults.standard.setValue(name, forKey: kName)
        UserDefaults.standard.setValue(apiEndpoint, forKey: kEndpoint)
    }
    
}
