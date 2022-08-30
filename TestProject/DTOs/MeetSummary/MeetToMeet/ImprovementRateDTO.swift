//
//  ImprovementRateDTO.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import Foundation

struct ImprovementRateDTO: Codable, Identifiable {
    
    var id = UUID().uuidString
    var runner: Runner
    var delta: String
    
    private enum CodingKeys: String, CodingKey {
            case runner
            case delta = "improvementRate"
    }
}
