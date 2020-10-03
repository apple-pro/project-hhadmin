//
//  CompanyAccountsDashboard.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/27/20.
//

import SwiftUI

struct CompanyAccountsDashboard: View {
    
    var backend = BackendAPI.shared
    
    @State var companyAccounts = [CompanyAccount]()
    
    var body: some View {
        List(companyAccounts) { companyAccount in
            Text(companyAccount.name)
        }
        .navigationTitle("Company Accounts")
        .navigationBarItems(trailing: Button(action: {
            backend.fetch("companyAccounts") { results in
                self.companyAccounts = results
            }
        }) {
            Image(systemName: "icloud.and.arrow.down")
        })
    }
}

struct CompanyAccountsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        CompanyAccountsDashboard()
    }
}
