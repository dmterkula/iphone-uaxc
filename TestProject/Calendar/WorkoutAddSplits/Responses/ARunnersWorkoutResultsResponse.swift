//
//  ARunnersWorkoutResultsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import Foundation

struct ARunnersWorkoutResultsResponse: Codable {
    
    var runner: Runner
    var workout: Workout
    var totalDistance: Double
    var componentResults: [SplitsResponse]
    
}
