//
//  HistoricalMeetComparisonDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import Foundation

struct HistoricalMeetComparisonResponse: Codable {
    
    var label: String
    var standardDeviation: Float
    var top10Percent: String
    var top25Percent: String
    var meanDifference: String
    var bottom25Percent: String
    var bottom10Percent: String
    var sampleSize: Int
    
    private enum CodingKeys: String, CodingKey {
        case standardDeviation, meanDifference, label
        case top10Percent = "10thPercentile"
        case top25Percent = "25thPercentile"
        case bottom25Percent = "75thPercentile"
        case bottom10Percent = "90thPercentile"
        case sampleSize = "samplesSize"
    }
    
}
