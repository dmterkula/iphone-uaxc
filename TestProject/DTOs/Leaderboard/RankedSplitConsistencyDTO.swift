//
//  RankedSplitConsistencyDTO.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import Foundation

struct RankedSplitConsistencyDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var consistencyValue: Double
    var rank: Int
    
    private enum CodingKeys: String, CodingKey {
        case runner, consistencyValue, rank
    }
}
