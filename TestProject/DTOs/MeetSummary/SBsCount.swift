//
//  SeasonBestsCount.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct SBsCount: Codable {
    var count: Int
    var seasonBests: [Performance]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case seasonBests
    }
}
