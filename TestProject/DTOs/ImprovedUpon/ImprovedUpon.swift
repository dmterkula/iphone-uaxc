//
//  ImprovedUpon.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct ImprovedUpon: Codable, Identifiable {
    
    var id = UUID().uuidString
    var meet: MeetResult?
    let timeDifference: String
    
    private enum CodingKeys: String, CodingKey {
            case meet = "meet"
            case timeDifference = "timeDifference"
        }
    
}
