//
//  CandidateForm.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidateForm: View {
    
    @State var candidate: Candidate
    
    var body: some View {
        Form {
            
            Section(header: Text("Profile")) {
                TextField("Name", text: $candidate.name)
            }
            
            Section(header: Text("Job Experience")) {
                
            }
        }
        .navigationTitle(candidate.name)
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Image(systemName: "folder")
        })
    }
}

struct CandidateForm_Previews: PreviewProvider {
    static var previews: some View {
        CandidateForm(candidate: mockCandidates[0])
    }
}
