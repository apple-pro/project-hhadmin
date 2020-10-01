//
//  ConfigurationSetup.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct ConfigurationSetup: View {
        
    @ObservedObject var configurationManager = ConfigurationManager.shared
    
    var backend = BackendAPI.shared
    
    @State var name = "Development"
    @State var apiEndpoint = "https://api.dev.kwler.net"
    @State var clientId = ""
    @State var clientSecret = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var testStatus: BackendAPI.TestStatus = .idle
    
    var body: some View {
        Form {
            Section(header: Text("Environment")) {
                TextField("Configuration", text: $name)
            }
            
            Section(header: Text("API Client")) {
                TextField("API Endpoint", text: $apiEndpoint)
                
                TextField("Client ID", text: $clientId)
                    .autocapitalization(.none)
                
                SecureField("Client Secret", text: $clientSecret)
            }
            
            Section(header: Text("Credentials")) {
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
            }
            
            Section {
                Text("Validation Status: \(testStatus.display)")
                
                switch testStatus {
                case .pass:
                    Button("Configure \(name)") {
                        configurationManager.configure(withName: name, api: apiEndpoint, clientId: clientId, andSecret: clientSecret)
                        
                        configurationManager.configureWithUsername(username, andPassword: password)
                    }
                default:
                    Button("Test") {
                        backend.performStatusTestOnAPI(apiEndpoint, clientId: clientId, clientSecret: clientSecret, username:username, password: password) { result in
                            self.testStatus = result
                        }
                    }
                }
            }
            
        }
    }
}

struct ConfigurationSetup_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSetup()
    }
}
