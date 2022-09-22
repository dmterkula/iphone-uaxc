//
//  GoalsDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/15/22.
//

import Foundation

struct GoalsDTO: Codable, Identifiable {
    
    var id = UUID()
    var season: String
    var type: String
    var value: String
    var met: Bool
    
    private enum CodingKeys: String, CodingKey {
        case season, type, value, met
    }
    
}
