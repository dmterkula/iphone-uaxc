//
//  WorkoutComponentResultsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 11/6/22.
//

import Foundation

struct WorkoutComponentSplitsResponse: Codable {
    var component: WorkoutComponent
    var results: [ComponentResult]
}

struct ComponentResult: Codable, Identifiable {
    var id = UUID()
    var runner: Runner
    var splits: [SplitElement]
    var average: String
    
    private enum CodingKeys: String, CodingKey {
        case runner, splits, average
    }
}
