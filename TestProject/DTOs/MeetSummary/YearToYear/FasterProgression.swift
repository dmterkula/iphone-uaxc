//
//  FasterProgression.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct Progression: Codable, Identifiable {
    var id = UUID().uuidString
    var runner: Runner
    var meetResults: [MeetResult]
    var progressions: [String]
    
    private enum CodingKeys: String, CodingKey {
            case runner
            case meetResults = "performances"
            case progressions = "progression"
        }
}


