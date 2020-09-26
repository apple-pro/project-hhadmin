//
//  ContentView.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/25/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authenticationManager = AuthenticationManager.shared
    @ObservedObject var configurationManager = ConfigurationManager.shared
    
    var body: some View {
        
        ZStack {
            if configurationManager.isNotConfigured {
                ConfigurationSetup()
            } else if authenticationManager.isAuthenticated {
                Dashboard()
            } else {
                Login()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
