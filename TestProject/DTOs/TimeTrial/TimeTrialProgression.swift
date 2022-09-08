//
//  TimeTrialProgression.swift
//  UAXC
//
//  Created by David  Terkula on 9/7/22.
//

import Foundation

struct TimeTrialProgression: Codable, Identifiable {
    
    var id = UUID()
    var rank: Int
    var runner: Runner
    var adjustedTimeTrial: String
    var seasonBest: String
    var improvement: String
    
    private enum CodingKeys: String, CodingKey {
        case rank, runner, adjustedTimeTrial, seasonBest, improvement
    }
    
}
