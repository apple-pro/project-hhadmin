//
//  ContentView.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/25/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authenticationManager = AuthenticationManager.standard
    
    var body: some View {
        
        ZStack {
            if authenticationManager.isAuthenticated {
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
