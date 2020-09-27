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
    private let kClientId = "config.clientId"
    private let kClientSecret = "config.clientSecret"
    
    @Published var name: String?
    @Published var apiEndpoint: String?
    @Published var clientId: String?
    @Published var clientSecret: String?
    
    private init() {
        apiEndpoint = Config.get(kEndpoint)
        name = Config.get(kName)
    }
    
    var isNotConfigured: Bool {
        name?.isEmpty ?? true || apiEndpoint?.isEmpty ?? true
    }
    
    func configure(withName name: String, api apiEndpoint: String, clientId: String, andSecret clientSecret: String) {
        self.name = name
        self.apiEndpoint = apiEndpoint
        self.clientId = clientId
        self.clientSecret = clientSecret
        
        Config.set(key: kName, name)
        Config.set(key: kEndpoint, apiEndpoint)
        Config.set(key: kClientId, clientId)
        Config.set(key: kClientSecret, clientSecret)
    }
    
}
