//
//  PR.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct Performance: Codable, Identifiable {
    var id = UUID().uuidString
    let result: [MeetResult]
    let runner: Runner
    var improvedUpon: ImprovedUpon
    
    private enum CodingKeys: String, CodingKey {
            case result = "pr"
            case runner
            case improvedUpon = "improvedUpon"
        }
    
}
