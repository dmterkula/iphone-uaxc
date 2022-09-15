//
//  TTestDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/10/22.
//

import Foundation

struct TTestDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var distributionSummaryBaseYear: [StatistialComparisonDTO]
    var distributionSummaryComparisonYear: [StatistialComparisonDTO]
    var tTestResults: [TTestResult]
    
    private enum CodingKeys: String, CodingKey {
        case distributionSummaryBaseYear, distributionSummaryComparisonYear
        case tTestResults = "ttestResults"
    }
    
}
