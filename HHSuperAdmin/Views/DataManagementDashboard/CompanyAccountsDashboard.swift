//
//  CompanyAccountsDashboard.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/27/20.
//

import SwiftUI

struct CompanyAccountsDashboard: View {
    
    @ObservedObject var backend = BackendAPI.shared
    
    var body: some View {
        List(backend.companyAccounts) { companyAccount in
            Text(companyAccount.name)
        }
        .navigationTitle("Company Accounts")
        .navigationBarItems(trailing: Button(action: {
            backend.fetchCandidates()
        }) {
            Image(systemName: "arrow.counterclockwise")
        })
    }
}

struct CompanyAccountsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        CompanyAccountsDashboard()
    }
}
