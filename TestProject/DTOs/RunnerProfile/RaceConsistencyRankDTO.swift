//
//  RaceConsistencyRankDTO.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import Foundation

struct RaceConsistencyRankDTO: Codable {
    
    var rank: Int
    var averageSpread: String
    
       
   private enum CodingKeys: String, CodingKey {
           case rank
           case averageSpread = "value"
       }
    
}
