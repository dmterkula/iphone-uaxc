//
//  CreateRunnersTotalMeetResultsRequest.swift
//  UAXC
//
//  Created by David  Terkula on 12/31/22.
//

import Foundation

struct CreateRunnersTotalMeetResultsRequest: Codable {
    
    var season: String
    var runnerId: Int
    var meetName: String
    var time: String
    var place: Int
    var passesLastMile: Int
    var passesSecondMile: Int
    var skullsEarned: Int
    var mileOneSplit: String
    var mileTwoSplit: String
    var mileThreeSplit: String
    
}
