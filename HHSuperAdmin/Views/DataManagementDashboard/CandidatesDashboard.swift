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
    @State var loading = false
    @State var advanceSearch = false
    
    @State var searchText = ""
    
    var body: some View {
        List {
            if loading {
                HStack(alignment: .center) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity)
            }
            
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
        .navigationBarItems(trailing: HStack {
            Button(action: loadData) {
                Image(systemName: "icloud.and.arrow.down")
            }.disabled(loading)
            
            Button(action: showSearch) {
                Image(systemName: "magnifyingglass")
            }.disabled(loading)
        })
        
        .onAppear {
            if candidates.isEmpty {
                loadData()
            }
        }
        
        .sheet(isPresented: $advanceSearch) {
            Form {
                Section(header: Text("Basic")) {
                    TextField("Search...", text: $searchText)
                }
                
                Section {
                    Button(action: showSearch) {
                        HStack(alignment: .center) {
                            Text("Search")
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
                
            }
        }
    }
    
    func loadData() {
        loading = true
        backend.fetch("candidates", withType: [Candidate].self) { results in
            self.candidates = results
            self.loading = false
        }
    }
    
    func showSearch() {
        advanceSearch.toggle()
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        CandidatesDashboard()
    }
}
