//
//  Runner.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct Runner: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var graduatingClass: String
    var runnerId: Int = -1
    var isActive: Bool
    
    private enum CodingKeys: String, CodingKey {
        case name, graduatingClass
        case runnerId = "id"
        case isActive = "active"
    }
}
