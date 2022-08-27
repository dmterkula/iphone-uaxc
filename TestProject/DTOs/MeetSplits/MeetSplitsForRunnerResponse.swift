//
//  MeetSplitsForRunnerResponse.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct MeetSplitsResponse: Codable {
    let runner: Runner
    let splits: [MeetSplit]
    
    enum CodingKeys: String, CodingKey {
        case runner = "runner"
        case splits = "mileSplits"
    }
}
