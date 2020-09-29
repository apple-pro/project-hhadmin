//
//  CandidateSearchFilter.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/29/20.
//

import SwiftUI

struct CandidateSearchFilter: View {
    
    @State private var searchText = ""
    
    let completionHandler: (String) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Basic")) {
                TextField("Search...", text: $searchText)
            }
            
            Section {
                Button(action: {
                    completionHandler(searchText)
                }) {
                    HStack(alignment: .center) {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            
        }
    }
}

struct CandidateSearchFilter_Previews: PreviewProvider {
    
    static var previews: some View {
        CandidateSearchFilter(completionHandler: {
            print($0)
        })
    }
}
