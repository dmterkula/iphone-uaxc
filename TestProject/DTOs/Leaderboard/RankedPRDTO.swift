//
//  RankedPRDTO.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import Foundation

struct RankedPRDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var result: MeetResult
    var rank: Int
    
    private enum CodingKeys: String, CodingKey {
            case runner, result, rank
        }
    
    
}
