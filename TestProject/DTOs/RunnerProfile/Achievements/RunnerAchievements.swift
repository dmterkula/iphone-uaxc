//
//  RunnerAchievements.swift
//  UAXC
//
//  Created by David  Terkula on 1/3/23.
//

import Foundation

struct RunnerAchievements: Codable {
    
    var prAchievements: [Achievement]
    var passesLastMileAchievements: [Achievement]
    var wonRaceAchievements: [Achievement]
    var consistentRaceAchievements: [Achievement]
    var totalTrainingDistanceAchievements: [Achievement]
    var loggedRunAchievement: [Achievement]
    var skullsEarnedStreak: StreakDTO
    var skullStreakAchievement: [Achievement]
    var totalSkullsEarnedAchievement: [Achievement]
    
    private enum CodingKeys: String, CodingKey {
        case prAchievements, passesLastMileAchievements, wonRaceAchievements, consistentRaceAchievements,
             totalTrainingDistanceAchievements,loggedRunAchievement, skullsEarnedStreak, skullStreakAchievement, totalSkullsEarnedAchievement
        
    }
    
}

struct StreakDTO: Codable {
    
    var currentStreak: Int
    var longestStreak: Int
    
    private enum CodingKeys: String, CodingKey {
        case currentStreak, longestStreak
    }
    
}

struct Achievement: Codable, Identifiable {
    
    var id = UUID()
    
    var threshold: Double
    var value: Double
    var met: Bool
    var imageName: String
    var description: String
    var valueIsInt: Bool
    
    private enum CodingKeys: String, CodingKey {
        case threshold, value, met, imageName, description, valueIsInt
        
    }
    
    func displayValueString() -> String {
        if self.valueIsInt {
            return  String(Int(self.value)) + " / " + String(Int(self.threshold))
        } else {
            return String(self.value) + " / " + String(self.threshold)
        }
            
    }
    
}
