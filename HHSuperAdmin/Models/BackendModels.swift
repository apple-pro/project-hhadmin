//
//  Candidate.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

struct Candidate {
    
    var id: String
    var name: String
    var jobDescription: String
}

struct CompanyAccount: Identifiable, Codable {
    let id: Int64
    let name: String
}
