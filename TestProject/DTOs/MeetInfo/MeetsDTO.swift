//
//  MeetsDTO.swift
//  UAXC
//
//  Created by David  Terkula on 9/4/22.
//

import Foundation

struct MeetDTO: Codable, Identifiable {
    
    var id = UUID()
    var name: String
    var dates: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name, dates
    }
    
}
