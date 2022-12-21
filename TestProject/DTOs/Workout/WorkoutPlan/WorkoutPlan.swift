//
//  WorkoutPlan.swift
//  UAXC
//
//  Created by David  Terkula on 12/18/22.
//

import Foundation

struct WorkoutPlanResponse: Codable {
    var runnerWorkoutPlans: [RunnerWorkoutPlan]
    var componentsToWorkoutPlans: [WorkoutComponentToRunnerPlans]
    
    private enum CodingKeys: String, CodingKey {
        case runnerWorkoutPlans = "runnerWorkoutPlanDTOV2"
        case componentsToWorkoutPlans = "componentsToRunnerWorkoutPlans"
        
    }
}

struct RunnerWorkoutPlan: Codable, Identifiable {
 
    var id = UUID()
    
    var runner: Runner
    var componentPlans: [ComponentPlans]
    
    private enum CodingKeys: String, CodingKey {
        case runner, componentPlans
    }
}

struct ComponentPlans: Codable, Identifiable {
    
    var id = UUID()
    
    var distance: Int
    var duration: String?
    var baseTime: String
    var targetedPace: [WorkoutPaceElement]
    
    private enum CodingKeys: String, CodingKey {
        case distance, duration, baseTime, targetedPace
    }
}

struct WorkoutComponentToRunnerPlans: Codable, Identifiable {
    
    var id = UUID()
    var component: WorkoutComponent
    var runnerWorkoutPlans: [RunnerWorkoutPlan]
    
    private enum CodingKeys: String, CodingKey {
        case component, runnerWorkoutPlans
    }
}

struct WorkoutPaceElement: Codable, Identifiable {
    
    var id = UUID()
    
    var type: String
    var pace: String
    
    private enum CodingKeys: String, CodingKey {
        case type, pace
    }
    
}
