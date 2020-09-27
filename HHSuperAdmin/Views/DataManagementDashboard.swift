//
//  DataManagementDashboard.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct DataManagementDashboard: View {
    var body: some View {
        List {
            Section(header: Text("ElasticSearch")) {
                NavigationLink(
                    destination: Candidates(),
                    label: { NavItem("Candidate", "person")}
                )
                
                NavigationLink(
                    destination: Candidates(),
                    label: { NavItem("Department", "person")}
                )
                
                NavigationLink(
                    destination: Candidates(),
                    label: { NavItem("Products", "person")}
                )
            }
            
            Section(header: Text("RDS")) {
                NavigationLink(
                    destination: Roles(),
                    label: { NavItem("Role", "lock.shield")}
                )
                
                NavigationLink(
                    destination: CompanyAccountsDashboard(),
                    label: { NavItem("Company Accounts", "person.2.square.stack")}
                )
                
                NavigationLink(
                    destination: Roles(),
                    label: { NavItem("User", "person.circle")}
                )
            }
        }.navigationTitle("Data Management")
    }
}

struct DataManagementDashboard_Previews: PreviewProvider {
    static var previews: some View {
        DataManagementDashboard()
    }
}
