//
//  Candidate.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import Foundation

typealias Resource = Identifiable & Codable

struct Candidate: Resource {
    
    var id: Int64 {
        candId
    }
    
    var candId: Int64
    var fullName: String
    var headline: String?
    
    var city: String?
    var state: String?
    var country: String?
    var location: Location?
    
    var currentCompanyName: String?
    var currentDepartment: String?
    var currentFunction: String?
    var currentWorkTitle: String?
}

struct CompanyAccount: Resource {
    let id: Int64
    let name: String
}

struct Location: Codable {
    let lat: Float
    let lon: Float
}
