//
//  Workout.swift
//  UAXC
//
//  Created by David  Terkula on 12/18/22.
//

import Foundation

struct WorkoutResponse: Codable {
    var workout: Workout
    var components: [WorkoutComponent]
}

struct Workout: Codable, Identifiable {
    var id = UUID()
    
    var date: Date
    var title: String
    var description: String
    var icon: String
    var uuid: UUID
    var components: [WorkoutComponent]
   
    func getComponentFromId(uuid: String) -> WorkoutComponent {
        
        return components.filter { workoutComponent in
            workoutComponent.uuid.uuidString.caseInsensitiveCompare(uuid) == .orderedSame
        }.first!
    }
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case date, description, title, uuid, icon, components
    }
    
    // Data to be used in the preview
    static var sampleWorkouts: [Workout] {
        
       
        
        return [
            
            Workout(date: Date().diff(numDays: 4), title: "800m repeats", description: "6-7x 800s at goal pace",  icon: "🦁", uuid: UUID.init(uuidString: "962c7f4c-2079-40c9-ada1-02b45e3dcbee")!, components:  [WorkoutComponent(description: "6-7x 800s at goal pace", type: "Interval", pace: "goal", targetDistance: 800, targetCount: 6, duration: "", targetPaceAdjustment: "", uuid: UUID.init(uuidString: "259a8fc3-0ae7-42fd-b141-0c13f840651c")!)]),
            
            Workout(date: Date().diff(numDays: 11), title: "Mile Repeats", description: "Mile repeats @PR pace", icon: "📌", uuid: UUID.init(uuidString: "37c1fe19-7e5c-4a45-a58a-00dc39f7e758")!, components:  [WorkoutComponent(description: "Mile repeats @PR pace", type: "Interval", pace: "goal", targetDistance: 1609, targetCount: 3, duration: "", targetPaceAdjustment: "", uuid: UUID.init(uuidString: "67e4f453-953b-4199-9286-7c5e1ae9cefd")!)])
            
        ]
    }
    
    static var workoutTypes = ["Interval", "Tempo", "Progression"]
    
    static var intervalDistances = [400, 800, 1000, 1200, 1600, 1609, 2000, 2413, 3200, 3218, 4827, 5000]
    
    static var tempoDistances: [Double] = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0]
    
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
    
    static var seconds = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
        "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
        "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
        "51", "52", "53", "54", "55", "56", "57", "58", "59"
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
    
    static var plusOrMinus = [
        "+",
        "-"
    ]
    
    static func getTextFromIcon(icon: String) -> String {
        return Workout.iconsToText[icon] == nil ? "default" : Workout.iconsToText[icon]!
    }
    
}


struct WorkoutComponent: Codable, Identifiable, Hashable {
    
    var id = UUID()
   
    var description: String
    var type: String
    var pace: String
    var targetDistance: Int
    var targetCount: Int
    var duration: String?
    var targetPaceAdjustment: String
    var uuid: UUID
    
    private enum CodingKeys: String, CodingKey {
        case description, type, pace, targetDistance, targetCount, duration, uuid, targetPaceAdjustment
    }
    
    func isPaceAdjustmentFaster() -> Bool {
        return targetPaceAdjustment.contains("-")
    }
    
    func isPaceAdjustment0() -> Bool {
        return targetPaceAdjustment == "0:00.0"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}
