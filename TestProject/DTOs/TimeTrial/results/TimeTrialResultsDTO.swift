//
//  TimeTrialResultsDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import Foundation

struct TimeTrialResultsDTO: Codable, Identifiable {
    
    var id = UUID()
    var runner: Runner
    var time: String
    var place: Int
    var season: String
    
    private enum CodingKeys: String, CodingKey {
        case runner, time, place, season
    }
    
}
