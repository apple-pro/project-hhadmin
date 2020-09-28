//
//  Candidates.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidatesDashboard: View {
    
    var backend = BackendAPI.shared
    
    @State var candidates: [Candidate] = [Candidate]()
    
    var body: some View {
        List {
            ForEach(candidates, id: \.self.id) { candidate in
                
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
            backend.fetch("candidates", withType: [Candidate].self) { results in
                self.candidates = results
            }
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
