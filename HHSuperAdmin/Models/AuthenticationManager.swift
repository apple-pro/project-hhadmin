//
//  AuthenticationManager.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var username: String?
    @Published var password: String?
    
    private init() {}
    
    var isAuthenticated: Bool {
        return !(username?.isEmpty ?? true || password?.isEmpty ?? true)
    }
    
    func set(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
