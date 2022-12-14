//
//  Performance.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct MeetResult: Codable, Identifiable {
    var id = UUID().uuidString
    let meetDate: String
    let meetName: String
    let place: Int
    let time: String
    let passesSecondMile: Int
    let passesLastMile: Int
    let skullsEarned: Int
    
    private enum CodingKeys: String, CodingKey {
            case meetDate, meetName, place, time, passesSecondMile, passesLastMile, skullsEarned
        }
    
}
