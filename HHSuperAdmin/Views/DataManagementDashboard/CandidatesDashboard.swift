//
//  Candidates.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

struct CandidatesDashboard: View {
    
    
    @Namespace private var animation
    @State var showSearchOverlay = true
    
    var body: some View {
        ZStack {
            CandidatesList(animation: animation, showSearchOverlay: $showSearchOverlay)
            
            
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
}

struct CandidatesList: View {
    
    var backend = BackendAPI.shared
    
    var animation: Namespace.ID
    
    @State var candidates: [Candidate] = [Candidate]()
    @State var loading = false
    @State var advanceSearch = false
    @State var searchText = ""
    
    @Binding var showSearchOverlay: Bool
    @State var recommendations = [SearchRecommendation]()
    
    var body: some View {
        List {
            if loading {
                HStack(alignment: .center) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity)
            }
            
            if !showSearchOverlay {
                TextField("Search ...", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        showSearchOverlay.toggle()
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
            }
            .disabled(loading)
        })
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        if candidates.isEmpty {
            loadData()
        }
    }
    
    func loadData() {
        loading = true
        backend.fetch("candidates") { (results: [Candidate]) in
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
    @Binding var searches: [SearchRecommendation]
    var animation: Namespace.ID
    
    let cancelHandler: () -> Void
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            HStack {
                
                TextField("Search ...", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
                Button(action: cancelHandler) {
                    Text("Cancel")
                        .foregroundColor(.accentColor)
                }
                .padding(.trailing, 10)
            }
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(searches, id: \.self.id) { recommendation in
                        HStack {
                            Text(recommendation.display)
                                .font(.caption)
                                .foregroundColor(recommendation.color)
                                .matchedGeometryEffect(id: "item:\(recommendation.id)", in: animation)
                            
                            Button(action: {
                                withAnimation {
                                    if let target = searches.firstIndex(where: { r in
                                        r.id == recommendation.id
                                    }) {
                                        searches.remove(at: target)
                                    }
                                }
                            }, label: {
                                Text("X")
                                    .font(.caption)
                                    .foregroundColor(recommendation.color)
                            })
                        }
                    }
                }
            }
        }
    }
}

struct SearchOverlay: View {
    
    var animation: Namespace.ID
    
    @State var text = ""
    @State var recommendations = [SearchRecommendation]()
    @State var availableRecommendations = [SearchRecommendation]()
    
    let onCancel: () -> Void
    let onSearch: (String) -> Void
    
    var body: some View {
        
        VStack {
            
            SearchBar(text: $text, searches: $recommendations, animation: animation, cancelHandler: onCancel)
            
            List(availableRecommendations) { recommendation in
                HStack {
                    Image(systemName: recommendation.icon)
                        .renderingMode(.template)
                        .foregroundColor(recommendation.color)
                        .padding(.all, 5)
                        .border(recommendation.color, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    Text(recommendation.display)
                        .foregroundColor(recommendation.color)
                }
                .matchedGeometryEffect(id: "item:\(recommendation.id)", in: animation)
                .onTapGesture(count: 2) {
                    
                    withAnimation {

                        if let target = availableRecommendations.firstIndex(where: { r in
                            r.id == recommendation.id
                        }) {
                            availableRecommendations.remove(at: target)
                            recommendations.append(recommendation)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.overlayBackground)
        .opacity(0.99)
        .onAppear {
            availableRecommendations = mockSearchRecommendation
        }
    }
}

struct Candidates_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CandidatesDashboard()
        }
    }
}
