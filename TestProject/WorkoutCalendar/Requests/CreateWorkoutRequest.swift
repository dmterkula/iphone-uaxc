//
//  CreateWorkoutRequest.swift
//  UAXC
//
//  Created by David  Terkula on 10/9/22.
//

import Foundation

struct CreateWorkoutRequest: Codable {
    
    var date: String
    var title: String
    var description: String
    var icon: String
    var uuid: String
    var components: [ComponentCreationElement]
    
}

struct ComponentCreationElement: Codable {
    
    var description: String
    var type: String
    var pace: String
    var targetDistance: Int
    var targetCount: Int
    var duration: String?
    var targetPaceAdjustment: String
    var uuid: String
    
}
