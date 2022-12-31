//
//  ARunnersWorkoutResultsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import Foundation

struct ARunnersWorkoutResultsResponse: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var workout: Workout
    var totalDistance: Double
    var componentResults: [SplitsResponse]
    
    
    private enum CodingKeys: String, CodingKey {
        case runner, workout, totalDistance, componentResults
    }
}
