//
//  RankedRunnerDistanceRunDTO.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import Foundation

struct RankedRunnerDistanceRunDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var distance: Double
    var rank: Int
    
    private enum CodingKeys: String, CodingKey {
        case runner, distance, rank
    }
}
