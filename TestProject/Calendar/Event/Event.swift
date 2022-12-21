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
