//
//  Candidate.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

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

struct SearchRecommendation: Resource {
    
    let id: String
    let display: String
    let type: String
    
    let value: [String:String]
    
    var color: Color {
        switch type {
        case "JOBEXP":
            return Color.green
        case "SKILL":
            return Color.orange
        case "JUMPER":
            return Color.red
        default:
            return Color.gray
        }
    }
    
    var icon: String {
        switch type {
        case "JOBEXP":
            return "clock"
        case "SKILL":
            return "pencil.and.outline"
        case "JUMPER":
            return "paperplane"
        default:
            return "doc"
        }
    }
    
}
