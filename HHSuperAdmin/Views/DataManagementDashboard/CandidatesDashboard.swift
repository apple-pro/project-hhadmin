//
//  Candidates.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidatesDashboard: View {
    
    var backend = BackendAPI.shared
    
    @Namespace private var animation
    
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
                    SearchBar(text: $searchText, tapHandler: showSearch) {
                        
                    }
                    .matchedGeometryEffect(id: "SearchBar", in: animation)
                    .transition(.opacity)
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
                }
                .disabled(loading)
            })
            .onAppear(perform: onAppear)
            
            
            if showSearchOverlay {
                SearchOverlay(animation: animation, onCancel: {
                    withAnimation {
                        showSearchOverlay.toggle()
                    }
                    
                }) {
                    print("Searched: \($0)")
                }
                .transition(.opacity)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(showSearchOverlay)
    }
    
    func onAppear() {
        if candidates.isEmpty {
            loadData()
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
        withAnimation {
            showSearchOverlay.toggle()
        }
    }
}

struct SearchBar: View {
    
    @Binding var text: String
    
    let tapHandler: () -> Void
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
                    tapHandler()
                }
 
            Button(action: cancelHandler) {
                Text("Cancel")
            }
            .padding(.trailing, 10)
        }
    }
}

struct SearchOverlay: View {
    
    let animation: Namespace.ID
    
    @State var text = ""
    
    let onCancel: () -> Void
    let onSearch: (String) -> Void
    
    var body: some View {
        
        VStack {
            
            SearchBar(text: $text, tapHandler: {}, cancelHandler: onCancel)
                //.matchedGeometryEffect(id: "SearchBar", in: animation)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.overlayBackground)
        .opacity(0.99)
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CandidatesDashboard(candidates: mockCandidates)
        }
    }
}
