//
//  LogWorkoutRequest.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import Foundation

struct LogWorkoutRequest: Codable {
    
    var runnerId: Int
    var workoutUuid: String
    var totalDistance: Double
    var componentsSplits: [LogComponentsSplitsRequest]

}

struct LogComponentsSplitsRequest: Codable {
    var componentUUID: String
    var splits: [Split]
}
 
