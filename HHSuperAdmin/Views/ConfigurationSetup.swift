//
//  ConfigurationSetup.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct ConfigurationSetup: View {
    
    let configurationManager = ConfigurationManager.shared
    
    @State var name = "Development"
    @State var apiEndpoint = "https://dev.api.kwler.net"
    
    var body: some View {
        Form {
            Section(header: Text("Backend Server")) {
                TextField("Configuration", text: $name)
                TextField("API Endpoint", text: $apiEndpoint)
            }
            
            Button("Setup") {
                configurationManager.configure(withName: name, andAPI: apiEndpoint)
            }
        }
    }
}

struct ConfigurationSetup_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSetup()
    }
}
