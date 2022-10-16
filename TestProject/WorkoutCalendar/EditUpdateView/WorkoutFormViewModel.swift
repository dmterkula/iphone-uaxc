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
    @Published var description: String = ""
    @Published var uuid: UUID = UUID()
    @Published var icon: String = "📌"
    @Published var components: [WorkoutComponentFormViewModel] = []

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ workout: Workout) {
        self.date = workout.date
        self.title = workout.title
        self.id = workout.id.uuidString
        self.description = workout.description
        self.uuid = workout.uuid
        self.icon = workout.icon
        self.components = workout.components.map { WorkoutComponentFormViewModel($0) }
    }
    
    func addComponent() {
        self.components.append(WorkoutComponentFormViewModel(WorkoutComponent(description: "", type: "Interval", pace: "Goal", targetDistance: 400, targetCount: 1, targetPaceAdjustment: "0:00", uuid: UUID())))
    }

    var incomplete: Bool {
        title.isEmpty || components.isEmpty
    }
}
