//
//  MeetPerformance.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct MeetPerformance: Codable, Identifiable {
    var id = UUID().uuidString
    let result: [MeetResult]
    let runner: Runner
    
    private enum CodingKeys: String, CodingKey {
            case result = "performance"
            case runner
        }
    
}
