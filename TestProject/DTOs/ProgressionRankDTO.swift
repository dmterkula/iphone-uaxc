//
//  ProgressionRankDTO.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import Foundation

struct ProgressionRankDTO: Codable {
    
    var rank: Int
    var improvementFromTimeTrial: String
       
   private enum CodingKeys: String, CodingKey {
       case rank
       case improvementFromTimeTrial = "value"
   }
    
}
