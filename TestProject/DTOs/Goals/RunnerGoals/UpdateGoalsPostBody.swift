//
//  UpdateGoalsPostBody.swift
//  UAXC
//
//  Created by David  Terkula on 9/18/22.
//

import Foundation
struct UpdateGoalsPostBody : Codable {
    
    var existingGoal: GoalElement
    var updatedGoal: GoalElement
    
}
