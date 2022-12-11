//
//  Event.swift
//  UAXC
//
//  Created by David  Terkula on 11/12/22.
//

import Foundation


enum EventType: CustomStringConvertible, Equatable, CaseIterable {
    case workout
    case meet
    case training
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .workout: return "Workout"
        case .meet: return "Meet"
        case .training: return "Training"
        }
      }
    
}

class Event: Identifiable, Hashable {

    var id = UUID()
    
    var title: String
    var date: Date
    var description: String?
    var icon: String = "📌"
    var uuid: String
    var type: EventType
    
    init (
        title: String,
        date: Date,
        description: String?,
        icon: String?,
        uuid: String,
        type: EventType
    ) {
        self.title = title
        self.date = date
        self.description = description
        if (icon != nil) {
            self.icon = icon!
        }
        self.uuid = uuid
        self.type = type
    }
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}

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

class MeetEvent: Event {
    init (meet: Meet) {
        super.init(
            title: meet.name,
            date: meet.date,
            description: nil,
            icon: meet.icon,
            uuid: meet.uuid,
            type: EventType.meet
        )
    }
}

class TrainingRunEvent: Event {
    
    var distance: Double?
    var time: String?
    
    init (trainingRun: TrainingRun) {
        
        self.distance = trainingRun.distance
        self.time = trainingRun.time
        
        super.init(
            title: trainingRun.name,
            date: trainingRun.date,
            description: nil,
            icon: trainingRun.icon,
            uuid: trainingRun.uuid,
            type: EventType.training
        )
    }
    
    func toTrainingRun() -> TrainingRun {
        return TrainingRun(name: self.title, date: self.date, time: self.time, distance: self.distance, icon: self.icon, uuid: self.icon)
    }
}
