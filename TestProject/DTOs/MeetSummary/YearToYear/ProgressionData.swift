//
//  ProgressionData.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct ProgressionData: Codable, Identifiable {
    
    var id = UUID().uuidString
    var fasterProgressions: ProgressionList
    var slowerProgressions: ProgressionList
    
    private enum CodingKeys: String, CodingKey {
        case fasterProgressions = "fasterProgression"
        case slowerProgressions = "slowerProgressions"
    }
}
