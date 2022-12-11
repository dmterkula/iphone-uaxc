//
//  WorkoutComponentFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 10/8/22.
//

import Foundation

class WorkoutComponentFormViewModel: ObservableObject, Identifiable {
    
    @Published var workoutType: String = "Interval"
    @Published var description: String = ""
    @Published var pace: String = "Goal"
    @Published var duration: String = "1"
    @Published var targetDistance: Int = 0
    @Published var targetCount: Int = 0
    @Published var uuid: UUID = UUID()
    @Published var paceAdjustmentRaw: Double = 0.0
    @Published var targetPaceAdjustment: String = "0:00"

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ workoutComponent: WorkoutComponent) {
        self.workoutType = workoutComponent.type
        self.id = workoutComponent.id.uuidString
        self.description = workoutComponent.description
        self.duration = workoutComponent.duration ?? "1"
        self.targetCount = workoutComponent.targetCount
        self.targetDistance = workoutComponent.targetDistance
        self.pace = workoutComponent.pace
        self.uuid = workoutComponent.uuid
        self.targetPaceAdjustment = workoutComponent.targetPaceAdjustment
        self.paceAdjustmentRaw = workoutComponent.targetPaceAdjustment.calculateSecondsFrom()
    }

    var incomplete: Bool {
        workoutType.isEmpty || pace.isEmpty || targetDistance == 0 || description == ""
    }
    
}
