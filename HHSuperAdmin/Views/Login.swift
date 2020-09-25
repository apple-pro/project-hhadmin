//
//  Login.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct Login: View {
    
    @ObservedObject var authenticationManager = AuthenticationManager.standard
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            
            Divider()
            
            Button("Login") {
                authenticationManager.set(username: username, password: password)
            }
        }
        .padding()
        .frame(maxWidth: 300)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
