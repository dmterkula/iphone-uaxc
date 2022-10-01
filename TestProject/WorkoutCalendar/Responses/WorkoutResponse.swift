//
//  WorkoutPlanResponse.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import Foundation



struct WorkoutResponse: Codable {
    var workout: Workout
}

struct WorkoutPlanResponse: Codable {
    var workoutPlans: [RunnerWorkoutPlan]
}

struct RunnerWorkoutPlan: Codable, Identifiable {
 
    var id = UUID()
    
    var runner: Runner
    var baseTime: String
    var targetedPaces: [WorkoutPaceElement]
    
    private enum CodingKeys: String, CodingKey {
        case runner, baseTime, targetedPaces
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

struct Workout: Codable, Identifiable {
    var id = UUID()
    
    var date: Date
    var type: String
    var title: String
    var description: String
    var targetDistance: Int
    var targetCount: Int
    var pace: String
    var duration: String
    var icon: String
    var uuid: UUID
   
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    
    private enum CodingKeys: String, CodingKey {
        
        case date, type, description, title, targetDistance, targetCount, pace, duration, uuid, icon
        
    }
    
    // Data to be used in the preview
    static var sampleWorkouts: [Workout] {
        return [
            Workout(date: Date().diff(numDays: 4), type: "Interval", title: "800m repeats", description: "6-7x 800s at goal pace", targetDistance: 800, targetCount: 6, pace: "goal", duration: "", icon: "🦁", uuid: UUID.init(uuidString: "962c7f4c-2079-40c9-ada1-02b45e3dcbee")!),
            Workout(date: Date().diff(numDays: 11), type: "Interval", title: "Mile Repeats", description: "Mile repeats @PR pace", targetDistance: 1609, targetCount: 3, pace: "goal", duration: "", icon: "📌", uuid: UUID.init(uuidString: "37c1fe19-7e5c-4a45-a58a-00dc39f7e758")!)
            
        ]
    }
    
    static var workoutTypes = ["Interval", "Tempo", "Progression"]
    
    static var intervalDistances = [400, 800, 1000, 1200, 1609, 2000, 2413]
    
    static var intervalCounts = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
        11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
        21, 22, 23, 24, 25, 26, 27, 28, 29, 30
    ]
    
    static var targetPaces = ["SB", "SB Avg", "PR", "Goal"]
    
    static var mintues = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
        "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
        "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
        "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"
    ]
    
    static var icons: [String] = [
        "📌",
        "⭐️",
        "🦁",
        "🏃‍♀️",
    ]
    
    static var iconsToText = [
        "📌": "default",
        "⭐️": "star",
        "🦁": "lion",
        "🏃‍♀️": "runner"
        ]
    
    static func getTextFromIcon(icon: String) -> String {
        return Workout.iconsToText[icon] == nil ? "default" : Workout.iconsToText[icon]!
    }
    
}
