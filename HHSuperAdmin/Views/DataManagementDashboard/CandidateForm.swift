//
//  CandidateForm.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidateForm: View {
    
    var candidate: Candidate
    
    @State var headline = ""
    @State var currentCompanyName = ""
    @State var currentWorkTitle = ""
    @State var currentFunction = ""
    
    init(_ candidate: Candidate) {
        self.candidate = candidate
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Profile (\(candidate.fullName))")) {
                TextField("Headline", text: $headline)
            }
            
            Section(header: Text("Current Job")) {
                TextField("Company", text: $currentCompanyName)
                TextField("Title", text: $currentWorkTitle)
                TextField("Function", text: $currentFunction)
            }
        }
        .navigationTitle("Candidate")
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Image(systemName: "icloud.and.arrow.up")
        }).onAppear {
            headline = candidate.headline ?? ""
            currentCompanyName = candidate.currentCompanyName ?? ""
            currentWorkTitle = candidate.currentWorkTitle ?? ""
            currentFunction = candidate.currentFunction ?? ""
        }
    }
}

struct CandidateForm_Previews: PreviewProvider {
    static var previews: some View {
        CandidateForm(mockCandidates[0])
    }
}
