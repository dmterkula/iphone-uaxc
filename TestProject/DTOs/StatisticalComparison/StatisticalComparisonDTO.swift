//
//  StatisticalComparisonDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/10/22.
//

import Foundation

struct StatistialComparisonDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var label: String
    var standardDeviation: Double
    var percentile10: String
    var percentile25: String
    var percentile75: String
    var percentile90: String
    var meanDifference: String
    var samplesSize: Int
    
    private enum CodingKeys: String, CodingKey {
        case label, standardDeviation, meanDifference, samplesSize
        case percentile10 = "10thPercentile"
        case percentile25 = "25thPercentile"
        case percentile75 = "75thPercentile"
        case percentile90 = "90thPercentile"
    }
    
}
