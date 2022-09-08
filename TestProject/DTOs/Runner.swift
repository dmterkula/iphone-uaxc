//
//  Runner.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct Runner: Codable, Identifiable {
    var id = UUID()
    let name: String
    let graduatingClass: String
    
    private enum CodingKeys: String, CodingKey {
        case name, graduatingClass
    }
}
