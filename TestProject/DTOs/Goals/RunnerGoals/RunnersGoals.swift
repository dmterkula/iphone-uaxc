//
//  GoalsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 9/15/22.
//

import Foundation

struct RunnersGoals: Codable, Identifiable {
    
    var id = UUID()
    var runner: Runner
    var goals: [GoalsDTO]
    
    private enum CodingKeys: String, CodingKey {
        case runner, goals
    }
    
}
