//
//  ConfigurationSetup.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct ConfigurationSetup: View {
    
    let configurationManager = ConfigurationManager.shared
    
    @State var name = "Development Server"
    @State var apiEndpoint = "https://dev.api.kwler.net"
    @State var clientId = ""
    @State var clientSecret = ""
    
    var body: some View {
        Form {
            Section(header: Text("Environment")) {
                TextField("Configuration", text: $name)
            }
            
            Section(header: Text("Backend Server")) {
                TextField("API Endpoint", text: $apiEndpoint)
                
                TextField("Client ID", text: $clientId)
                    .autocapitalization(.none)
                
                SecureField("Client Secret", text: $clientSecret)
            }
            
            Button("Configure") {
                configurationManager.configure(withName: name, api: apiEndpoint, clientId: clientId, andSecret: clientSecret)
            }
        }
    }
}

struct ConfigurationSetup_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSetup()
    }
}
