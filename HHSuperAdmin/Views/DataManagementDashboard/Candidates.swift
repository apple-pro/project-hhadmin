//
//  Candidates.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct Candidates: View {
    var body: some View {
        List {
            ForEach(mockCandidates, id: \.self.id) { candidate in
                
                NavigationLink(destination: CandidateForm(candidate: candidate)) {
                    VStack {
                        Text(candidate.name)
                        Text(candidate.jobDescription).font(.caption)
                    }
                }
                
            }
        }
        .navigationTitle("Candidates")
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Image(systemName: "plus")
        })
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        Candidates()
    }
}
