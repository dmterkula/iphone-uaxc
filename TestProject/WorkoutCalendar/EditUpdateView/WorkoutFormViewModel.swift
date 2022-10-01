//
//  WorkoutFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import Foundation

class WorkoutFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var title = ""
    @Published var workoutType: String = "Interval"
    @Published var description: String = ""
    @Published var pace: String = "Goal"
    @Published var duration: String = "1"
    @Published var targetDistance: Int = 400
    @Published var targetCount: Int = 0
    @Published var uuid: UUID = UUID()
    @Published var icon: String = "📌"

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ workout: Workout) {
        self.date = workout.date
        self.title = workout.title
        self.workoutType = workout.type
        self.id = workout.id.uuidString
        self.description = workout.description
        self.duration = workout.duration
        self.targetCount = workout.targetCount
        self.targetDistance = workout.targetDistance
        self.pace = workout.pace
        self.uuid = workout.uuid
        self.icon = workout.icon
    }

    var incomplete: Bool {
        title.isEmpty
    }
}
