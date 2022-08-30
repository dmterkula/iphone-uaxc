//
//  MeetPerformanceResponse.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct MeetPerformanceResponse: Codable {
    let performances: [MeetPerformance]
    
    enum CodingKeys: String, CodingKey {
            case performances = "runnerMeetPerformanceDTOs"
    }
}
