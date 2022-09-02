//
//  AggregateStatsDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import Foundation

struct AggregateStatsResponse: Codable {
    
    var totalSplits: Int
    var total5Ks: Int
    var totalRunners: Int
    var aggregatePRStats: AggregatePRStats
    
}
