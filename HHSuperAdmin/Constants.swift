//
//  Constants.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/26/20.
//

import SwiftUI

extension Color {
    static let accent = Color("AccentColor")
    static let overlayBackground = Color("OverlayBackground")
}

let mockCandidates = [
    Candidate(candId: 1000001, fullName: "Johnny Kepler", currentWorkTitle: "Scientist"),
    Candidate(candId: 1000002, fullName: "Thomas Lord", currentWorkTitle: "Engineer"),
    Candidate(candId: 1000003, fullName: "Michael Scotch", currentWorkTitle: "Jobless")
]

let mockSearchRecommendation = [
    SearchRecommendation(id: "10000001", display: "Job Experience >5 Years", type: "JOBEXP", value: ["op":"eq", "number": "5"]),
    SearchRecommendation(id: "10000002", display: "Knows Microsoft Office", type: "SKILL", value: ["skill": "10001"]),
    SearchRecommendation(id: "10000003", display: "Likely to leave his job", type: "JUMPER", value: ["op":"eq", "number": "5"]),
    SearchRecommendation(id: "10000004", display: "Skilled in Java", type: "SKILL", value: ["skill": "10005"]),
    SearchRecommendation(id: "10000005", display: "Knows KungFu", type: "SKILL", value: ["skill": "100008"])
]
