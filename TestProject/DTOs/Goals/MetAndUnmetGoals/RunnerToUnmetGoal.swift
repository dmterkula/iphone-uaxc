//
//  RunnerToUnmetGoal.swift
//  UAXC
//
//  Created by David  Terkula on 9/22/22.
//

import Foundation

struct RunnerToUnmetGoalsResponse: Codable {
    var unMetGoals: [RunnerToUnmetGoal]
    
    private enum CodingKeys: String, CodingKey {
        case unMetGoals = "UnMetGoals"
    }
}

struct RunnerToUnmetGoal: Codable, Identifiable {
    
    var id = UUID()
    var runner: Runner
    var closestPerformance: MeetResult
    var time: String
    var difference: String
    
    private enum CodingKeys: String, CodingKey {
        case runner, closestPerformance, time, difference
    }
}

