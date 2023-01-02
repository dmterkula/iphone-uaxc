//
//  TotalMeetPerformanceDTO.swift
//  UAXC
//
//  Created by David  Terkula on 12/31/22.
//

import Foundation

struct RunnerTotalMeetPerformanceDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var performance: TotalMeetPerformanceDTO
    
    enum CodingKeys: String, CodingKey {
        case runner, performance
    }
    
}

struct TotalMeetPerformanceDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var meetName: String
    var meetDate: String
    var time: String
    var place: Int
    var passesLastMile: Int
    var passesSecondMile: Int
    var skullsEarned: Int
    var mileOneSplit: String
    var mileTwoSplit: String
    var mileThreeSplit: String
    
    enum CodingKeys: String, CodingKey {
        case meetName, meetDate, time, place, passesLastMile, passesSecondMile, skullsEarned, mileOneSplit, mileTwoSplit, mileThreeSplit
    }
}
