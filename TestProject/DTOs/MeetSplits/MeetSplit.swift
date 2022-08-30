//
//  MeetSplit.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct MeetSplit: Codable, Identifiable {
    var id = UUID().uuidString
    let result: MeetResult
    let splits: Splits
    
    private enum CodingKeys: String, CodingKey {
            case result = "meetPerformanceDTO"
            case splits = "meetSplitsDTO"
        }
    
}
