//
//  MeetYearToYearProgression.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct MeetYearToYearProgression: Codable{
    
    var progression: ProgressionData
    
    private enum CodingKeys: String, CodingKey {
        case progression = "comparisonFromLastYear"
    }
}
