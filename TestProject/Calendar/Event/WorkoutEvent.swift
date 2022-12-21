//
//  WorkoutEvent.swift
//  UAXC
//
//  Created by David  Terkula on 12/18/22.
//

import Foundation

class WorkoutEvent: Event {
    
    var components: [WorkoutComponent]
    
    init (workout: Workout) {
        
        self.components = workout.components
        
        super.init(
            title: workout.title,
            date: workout.date,
            description: workout.description,
            icon: workout.icon,
            uuid: workout.uuid.uuidString,
            type: EventType.workout
        )
    }
    
    func toWorkout() -> Workout {
        return Workout(date: self.date, title: self.title, description: self.description!, icon: self.icon, uuid: UUID(uuidString: self.uuid)!, components: self.components)
    }
    
}
