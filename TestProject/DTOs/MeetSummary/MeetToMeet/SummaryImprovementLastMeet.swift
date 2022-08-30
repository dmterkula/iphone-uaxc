//
//  SummaryImprovementLastMeet.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import Foundation

struct SummaryImprovementLastMeet: Codable {
    
    var averageDifference: String
    var medianDifference: String
    var faster: MeetToMeetProgressions
    var slower: MeetToMeetProgressions
    
}
