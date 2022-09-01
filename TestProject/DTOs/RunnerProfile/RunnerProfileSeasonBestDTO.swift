//
//  RunnerProfileSeasonBestDTO.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import Foundation

struct RunnerProfileSeasonBestDTO: Codable {
    
    var meetResult: MeetResult
    var meetSplits: Splits?
    
       
   private enum CodingKeys: String, CodingKey {
           case meetResult = "meetPerformanceDTO"
           case meetSplits = "meetSplitsDTO"
       }
}
