//
//  RunnerToMetGoal.swift
//  UAXC
//
//  Created by David  Terkula on 9/19/22.
//

import Foundation

struct NewlyMetGoalsResponse: Codable {
    var metGoals: [RunnerToMetGoal]
}

struct RunnerToMetGoal: Codable, Identifiable {
    var id = UUID()
    var runner: Runner
    var metGoals: [MetGoal]
    
    private enum CodingKeys: String, CodingKey {
        case runner, metGoals
    }
}
