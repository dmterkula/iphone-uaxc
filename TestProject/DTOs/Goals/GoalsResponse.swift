//
//  GoalsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 9/15/22.
//

import Foundation

struct GoalsResponse: Codable {
    
    var runner: Runner
    var goals: [GoalsDTO]
    
}
