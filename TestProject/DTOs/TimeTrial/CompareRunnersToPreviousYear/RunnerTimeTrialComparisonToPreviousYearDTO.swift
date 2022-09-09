//
//  RunnerTimeTrialComparisonToPreviousYearDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/8/22.
//

import Foundation

struct RunnerTimeTrialComparisonToPreviousYearDTO: Codable, Identifiable {
    
    var id = UUID()
    var runner: Runner
    var timeDifference: String
    var results: [TimeTrialResultsDTO]
    
    private enum CodingKeys: String, CodingKey {
        case runner, timeDifference, results
    }
    
}
