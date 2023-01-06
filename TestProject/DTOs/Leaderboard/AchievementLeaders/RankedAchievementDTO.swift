//
//  RankedAchievementDTO.swift
//  UAXC
//
//  Created by David  Terkula on 1/4/23.
//

import Foundation

struct RankedAchievementDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var rank: Int
    var count: Int
    
    private enum CodingKeys: String, CodingKey {
        case runner, rank, count
    }
    
    
}
    
