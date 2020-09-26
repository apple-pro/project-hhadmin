//
//  DataCleanupDashboard.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct DataCleanupDashboard: View {
    
    @State var deleteAll = true
    
    @State var deleteRoles = false
    @State var deleteAudit = true
    @State var deleteCompanies = true
    
    var body: some View {
        Form {
            
            if !deleteAll {
                
                Section(header: Text("Target Tables")) {
                    
                    Toggle(isOn: $deleteCompanies) {
                        Text("Companies")
                    }
                    
                    Toggle(isOn: $deleteRoles) {
                        Text("Roles")
                    }
                    
                    Toggle(isOn: $deleteAudit) {
                        Text("Audit Logs")
                    }
                }
                
            }
            
            Section {
                Button(action: {
                    //do delete
                }) {
                    HStack {
                        Image(systemName: "trash")
                        Text(deleteAll ? "Reset Database" : "Remove Selected Data")
                    }
                }
                
                Toggle(isOn: $deleteAll) {
                    Text("Delete All")
                }
            }
            
        }
    }
}

struct DataCleanupDashboard_Previews: PreviewProvider {
    static var previews: some View {
        DataCleanupDashboard()
    }
}
