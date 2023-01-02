//
//  AddRunnerMeetResultFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 12/31/22.
//

import Foundation

class AddRunnerMeetResultFormViewModel: ObservableObject {
    
    @Published var runner: Runner?
    @Published var meetName: String = ""
    @Published var season: String = ""
    @Published var place: Int = 0
    
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var milliseconds: Int = 0
    @Published var time: String = "00:00.0"
    
    @Published var passesLastMile: Int = 0
    @Published var passesSecondMile: Int = 0
    @Published var skullsEarned: Int = 0
    
    @Published var mileOneTime: String = "00:00"
    @Published var mileOneMinutes: Int = 0
    @Published var mileOneSeconds: Int = 0
    
    @Published var mileTwoTime: String = "00:00"
    @Published var mileTwoMinutes: Int = 0
    @Published var mileTwoSeconds: Int = 0
    
    @Published var mileThreeTime: String = "00:00"
    @Published var mileThreeMinutes: Int = 0
    @Published var mileThreeSeconds: Int = 0
    
    init(runner: Runner, season: String, performanceDTO: TotalMeetPerformanceDTO) {
        
        self.runner = runner
        self.season = season
                
        self.meetName = performanceDTO.meetName
        self.time = performanceDTO.time
        self.place = performanceDTO.place
        
        self.minutes = performanceDTO.time.getMinutesFrom()
        self.seconds = performanceDTO.time.getSecondsFrom()
        self.milliseconds = performanceDTO.time.getMillisecondsFrom()
        
        self.mileOneTime = performanceDTO.mileOneSplit
        self.mileOneMinutes = performanceDTO.mileOneSplit.getMinutesFrom()
        self.mileOneSeconds = performanceDTO.mileOneSplit.getSecondsFrom()
        
        self.mileTwoTime = performanceDTO.mileTwoSplit
        self.mileTwoMinutes = performanceDTO.mileTwoSplit.getMinutesFrom()
        self.mileTwoSeconds = performanceDTO.mileTwoSplit.getSecondsFrom()
        
        self.mileThreeTime = performanceDTO.mileThreeSplit
        self.mileThreeMinutes = performanceDTO.mileThreeSplit.getMinutesFrom()
        self.mileThreeSeconds = performanceDTO.mileThreeSplit.getSecondsFrom()
        
        self.passesLastMile = performanceDTO.passesLastMile
        self.passesSecondMile = performanceDTO.passesSecondMile
        self.skullsEarned = performanceDTO.skullsEarned
        
   }
    
    init(runner: Runner?, meet: String, season: String) {
        
        self.runner = runner
        self.season = season
        self.meetName = meet
   }
    
    
    func getTimeString() -> String {
        
        var minuteString = ""
        var secondString = ""
        var millisString = ""
        
        if (minutes < 10) {
            minuteString = "0" + String(minutes)
        } else {
            minuteString = String(minutes)
        }
        
        if (seconds < 10) {
            secondString = "0" + String(seconds)
        } else {
            secondString = String(seconds)
        }
        
        if (milliseconds < 10) {
            millisString = "0" + String(milliseconds)
        } else {
            millisString = String(milliseconds)
        }
        
        return minuteString + ":" + secondString + "." + millisString
        
    }
    
    func getMileOneSplitString() -> String {
            
        var minuteString = ""
        var secondString = ""
        
        if (mileOneMinutes < 10) {
            minuteString = "0" + String(mileOneMinutes)
        } else {
            minuteString = String(mileOneMinutes)
        }
        
        if (mileOneSeconds < 10) {
            secondString = "0" + String(mileOneSeconds)
        } else {
            secondString = String(mileOneSeconds)
        }
        
        return minuteString + ":" + secondString
            
    }
    
    func getMileTwoSplitString() -> String {
            
            var minuteString = ""
            var secondString = ""
            
            if (mileTwoMinutes < 10) {
                minuteString = "0" + String(mileTwoMinutes)
            } else {
                minuteString = String(mileTwoMinutes)
            }
            
            if (mileTwoSeconds < 10) {
                secondString = "0" + String(mileTwoSeconds)
            } else {
                secondString = String(mileTwoSeconds)
            }
            
            return minuteString + ":" + secondString
            
        }
    
    
    func getMileThreeSplitString() -> String {
            
        var minuteString = ""
        var secondString = ""
        
        if (mileThreeMinutes < 10) {
            minuteString = "0" + String(mileThreeMinutes)
        } else {
            minuteString = String(mileThreeMinutes)
        }
        
        if (mileThreeSeconds < 10) {
            secondString = "0" + String(mileThreeSeconds)
        } else {
            secondString = String(mileThreeSeconds)
        }
        
        return minuteString + ":" + secondString
        
    }
    
    func isComplete() -> Bool {
        
        if (runner != nil && minutes != 0 && place != 0 && !meetName.isEmpty && !season.isEmpty) {
            return true
        } else {
            return false
        }
        
    }
    
    

}
