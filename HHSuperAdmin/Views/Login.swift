//
//  Login.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var authenticationManager = AuthenticationManager.shared
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Credentials")) {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            
            Button("Login") {
                authenticationManager.set(username: username, password: password)
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
