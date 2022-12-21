//
//  RankedSBDTO.swift
//  UAXC
//
//  Created by David  Terkula on 12/13/22.
//

import Foundation

struct RankedSBDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var result: MeetResult
    var rank: Int
    
    private enum CodingKeys: String, CodingKey {
            case runner, result, rank
        }
    
}
