//
//  RunnerMeetPerformanceDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import Foundation

struct RunnerMeetPerformanceDTO: Codable {
    var runner: Runner
    var performance: [MeetResult]
}
