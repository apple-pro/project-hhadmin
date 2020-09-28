//
//  CandidateForm.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidateForm: View {
    
    @State var candidate: Candidate?
    
    @State var headline = ""
    @State var currentCompanyName = ""
    @State var currentWorkTitle = ""
    @State var currentFunction = ""
    
    init(_ c: Candidate) {
        self.candidate = c
        self.headline = c.headline ?? ""
        self.currentCompanyName = c.currentCompanyName ?? ""
        self.currentWorkTitle = c.currentWorkTitle ?? ""
        self.currentFunction = c.currentFunction ?? ""
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Profile")) {
                TextField("Headline", text: $headline)
            }
            
            Section(header: Text("Current Job")) {
                TextField("Company", text: $currentCompanyName)
                TextField("Title", text: $currentWorkTitle)
                TextField("Function", text: $currentFunction)
            }
        }
        .navigationTitle(candidate?.fullName ?? "New Candidate")
        .navigationBarItems(trailing: Button(action: {
            
        }) {
            Image(systemName: "folder")
        })
    }
}

struct CandidateForm_Previews: PreviewProvider {
    static var previews: some View {
        CandidateForm(mockCandidates[0])
    }
}
