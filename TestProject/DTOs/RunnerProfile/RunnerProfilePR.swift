//
//  RunnerProfilePR.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import Foundation

struct RunnerProfilePR: Codable {
    var meetResult: MeetResult
       
   private enum CodingKeys: String, CodingKey {
       case meetResult = "meetPerformanceDTO"
   }
}
