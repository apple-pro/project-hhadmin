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
    
    @State var showSearchOverlay = false
    
    var body: some View {
        ZStack {
            List {
                if loading {
                    HStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .frame(maxWidth: .infinity)
                }
                
                if !showSearchOverlay {
                    SearchBar(text: $searchText) {
                        
                    }
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
            
//            .sheet(isPresented: $advanceSearch) {
//                CandidateSearchFilter() { searchResult in
//                    print("Searched For: \(searchResult)")
//                    advanceSearch.toggle()
//                }
//            }
            
            if showSearchOverlay {
                SearchOverlay(onCancel: {
                    showSearchOverlay = false
                }) {
                    print("Searched: \($0)")
                }.animation(.easeIn)
            }
        }.navigationBarHidden(showSearchOverlay)
    }
    
    func loadData() {
        loading = true
        backend.fetch("candidates", withType: [Candidate].self) { results in
            self.candidates = results
            self.loading = false
        }
    }
    
    func showSearch() {
        //advanceSearch.toggle()
        showSearchOverlay = true
    }
}

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    let cancelHandler: () -> Void
 
    var body: some View {
        HStack {
 
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchOverlay: View {
    
    @State var text = ""
    
    let onCancel: () -> Void
    let onSearch: (String) -> Void
    
    var body: some View {
        
        VStack {
            
            SearchBar(text: $text, cancelHandler: onCancel)
            
            Spacer()
            
            Button(action: {
                onSearch(text)
            }) {
                Text("Search")
            }
            
            Button(action: onCancel) {
                Text("Cancel")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .opacity(0.95)
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CandidatesDashboard(candidates: mockCandidates)
        }
    }
}
