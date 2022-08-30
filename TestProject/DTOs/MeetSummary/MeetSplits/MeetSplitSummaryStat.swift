//
//  MeetSplitSummaryStat.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import Foundation

struct MeetSplitSummaryStat: Codable, Identifiable {
    
    var id = UUID().uuidString
    var label: String
    var value: Float
    
    private enum CodingKeys: String, CodingKey {
            case label = "name"
            case value
        }
    
}
