//
//  CompanySetup.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CompanySetup: View {
    
    @State var companyName = ""
    @State var masterCompanyId = "1000001"
    @State var internalCompany = false
    
    @State var adminName = ""
    @State var adminEmail = ""
    @State var adminUsername = ""
    @State var adminPassword = ""
    @State var adminPasswordVerify = ""
    @State var showPassword = false
    
    @State var enforceDataSecurity = false
    
    var body: some View {
        
        Form {
            Section(header: Text("Company")) {
                TextField("Company", text: $companyName)
                
                Picker(selection: $masterCompanyId, label: Text("Reference")) {
                    Text("Headhuntr.io").tag("1000001")
                    Text("Orange and Bronze Software Labs").tag("1000002")
                    Text("ING").tag("1000003")
                }
                
                Toggle(isOn: $internalCompany) {
                    VStack(alignment: .leading) {
                        Text(internalCompany ? "Internal" : "Public")
                        Text(internalCompany ? "Internal Test Company" : "A Real Company")
                            .font(.caption2)
                    }
                }
            }
            
            Section(header: Text("Administrator")) {
                TextField("Full Name", text: $adminName)
                
                TextField("Email", text: $adminEmail)
                
                TextField("Username", text: $adminUsername)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $adminPassword)
                
                HStack {
                    if showPassword {
                        TextField("Verify Password", text: $adminPasswordVerify)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Verify Password", text: $adminPasswordVerify)
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }, label: {
                        Image(systemName: "eye")
                    })
                    
                }
            }
            
            if !internalCompany {
                Section(header: Text("Restriction")) {
                    Toggle(isOn: $enforceDataSecurity) {
                        Text("Restricted Access to Departments")
                    }
                }
            }
            
            if !companyName.isEmpty {
                Button(action: {
                    //create company
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Create Company: \(companyName)")
                    }
                }
            }
            
        }.navigationTitle("Setup New Company")
    }
}

struct CompanySetup_Previews: PreviewProvider {
    static var previews: some View {
        CompanySetup()
    }
}
