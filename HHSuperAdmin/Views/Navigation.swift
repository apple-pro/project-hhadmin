//
//  Navigation.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
        List {
            NavigationLink(
                destination: Text("TODO"),
                label: {
                    NavItem("Account", "person.circle")
            })
            
            Section(header: Text("Application")) {
                NavigationLink(
                    destination:Text("TODO"),
                    label: { NavItem("Deployment", "icloud.and.arrow.up")}
                )
                
                NavigationLink(
                    destination: Text("TODO"),
                    label: { NavItem("Monitoring", "tv")}
                )
                
                NavigationLink(
                    destination: Text("TODO"),
                    label: { NavItem("Configuration", "slider.horizontal.3")}
                )
            }
            
            Section(header: Text("Data")) {
                NavigationLink(
                    destination: CompanySetup(),
                    label: { NavItem("Setup", "person.crop.circle.badge.plus")}
                )
                
                NavigationLink(
                    destination:Text("TODO"),
                    label: { NavItem("Management", "square.and.pencil")}
                )
                
                NavigationLink(
                    destination: Text("TODO"),
                    label: { NavItem("Processing", "arrow.up.arrow.down.circle")}
                )
                
                NavigationLink(
                    destination: DataCleanupDashboard(),
                    label: { NavItem("Cleanup", "trash")}
                )
            }
            
        }.listStyle(SidebarListStyle()).navigationTitle("Super Admin")
    }
}

struct NavItem: View {
    
    let title: String?
    let image: String?
    
    init(_ title: String?, _ image: String?) {
        self.title = title
        self.image = image
    }
    
    var body: some View {
        HStack {
            Image(systemName: image ?? "questionmark.circle")
            Text(title ?? "Unknown")
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
