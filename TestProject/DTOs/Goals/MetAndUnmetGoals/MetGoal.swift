//
//  MetGoals.swift
//  UAXC
//
//  Created by David  Terkula on 9/19/22.
//

import Foundation

struct MetGoal: Codable, Identifiable {
    
    var id = UUID()
    var time: String
    var at: MeetResult
    
    private enum CodingKeys: String, CodingKey {
        case time, at
    }
}
