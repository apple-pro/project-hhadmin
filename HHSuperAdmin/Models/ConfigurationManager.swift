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
    
    //TODO: store this in keychain, plaintext files are absolutely insecure
    private let kUsername = "credentials.backend.username"
    private let kPassword = "credentials.backend.password"
    
    @Published var name: String?
    @Published var apiEndpoint: String?
    @Published var clientId: String?
    @Published var clientSecret: String?
    
    @Published var username: String?
    @Published var password: String?
    
    private init() {
        name = Config.get(kName)
        apiEndpoint = Config.get(kEndpoint)
        clientId = Config.get(kClientId)
        clientSecret = Config.get(kClientSecret)
        
        username = Config.get(kUsername)
        password = Config.get(kPassword)
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
    
    func configureWithUsername(_ username: String, andPassword password: String) {
        self.username = username
        self.password = password
        
        Config.set(key: kUsername, username)
        Config.set(key: kPassword, password)
    }
    
}
