//
//  Candidates.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidatesDashboard: View {
    
    @ObservedObject var backend = BackendAPI.shared
    
    var body: some View {
        List {
            ForEach(backend.candidates, id: \.self.id) { candidate in
                
                NavigationLink(destination: CandidateForm(candidate)) {
                    VStack(alignment: .leading) {
                        Text(candidate.fullName)
                            .font(.title)
                        
                        Text(candidate.currentCompanyName ?? "Jobless")
                            .font(.caption)
                    }
                }
                
            }
        }
        .navigationTitle("Candidates")
        .navigationBarItems(trailing: Button(action: {
            backend.fetchCandidates()
        }) {
            Image(systemName: "icloud.and.arrow.down")
        })
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        CandidatesDashboard()
    }
}
