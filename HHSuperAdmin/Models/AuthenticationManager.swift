//
//  AuthenticationManager.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    //TODO: store this in keychain, plaintext files are absolutely insecure
    private let kUsername = "credentials.backend.username"
    private let kPassword = "credentials.backend.password"
    
    @Published var username: String?
    @Published var password: String?
    
    var isNotAuthenticated: Bool {
        username?.isEmpty ?? true || password?.isEmpty ?? true
    }
    
    private init() {
        username = Config.get(kUsername)
        password = Config.get(kPassword)
    }
    
    func set(username: String, password: String) {
        self.username = username
        self.password = password
        
        Config.set(key: kUsername, username)
        Config.set(key: kPassword, password)
    }
}
