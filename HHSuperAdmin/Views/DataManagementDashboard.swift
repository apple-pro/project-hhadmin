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
                    destination: CandidatesDashboard(),
                    label: { NavItem("Candidate", "person")}
                )
                
                NavigationLink(
                    destination: CandidatesDashboard(),
                    label: { NavItem("Department", "person")}
                )
                
                NavigationLink(
                    destination: CandidatesDashboard(),
                    label: { NavItem("Products", "person")}
                )
            }
            
            Section(header: Text("RDS")) {
                NavigationLink(
                    destination: RolesDashboard(),
                    label: { NavItem("Role", "lock.shield")}
                )
                
                NavigationLink(
                    destination: CompanyAccountsDashboard(),
                    label: { NavItem("Company Accounts", "person.2.square.stack")}
                )
                
                NavigationLink(
                    destination: RolesDashboard(),
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
