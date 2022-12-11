//
//  GlobalFunctions.swift
//  UAXC
//
//  Created by David  Terkula on 12/3/22.
//

import Foundation
import SwiftUI

struct GlobalFunctions {
    
    static func gold() -> Color {
        return Color(red: 249/255, green: 229/255, blue: 0/255)
    }
    
    static func uaGreen() -> Color {
        return Color(red: 5/255, green: 112/255, blue: 0/255)
    }
    
    static func convertMinuteSecondStringToSeconds(time: String) -> Int {
        
        let components: [String] = time.components(separatedBy: " ")
        
        let seconds: Int = Int(components[0])! * 60 + Int(components[1])!
        
        
        return seconds
    }
    
    static func getSecondsValueFromMinuteSecondString(time: String) -> Int {
        let components: [String] = time.components(separatedBy: ":")
        
        let seconds: Int = Int(components[1])!
        
        return seconds
    }
    
    static func getMinutesValueFromMinuteSecondString(time: String) -> Int {
        let components: [String] = time.components(separatedBy: ":")
        
        let minutes: Int = Int(components[0])!
        
        return minutes
    }
    
    static func convertSecondsToMinuteSecondString(seconds: Int) -> String {
        
        let minutes: Double = Double(seconds) / 60.0
        let roundedMinutes = Int(minutes)
        
        if (seconds == 0) {
            return "00:00"
        }
        
        else if (minutes < 0) {
            
            return "00:" + String(seconds)
            
        } else {
            let seconds =  Double(seconds).truncatingRemainder(dividingBy: 60)
            return String(roundedMinutes) + ":" + String(Int(seconds))
        }
    }
    
    static func getPacePerMile(time: String, distance: Double) -> String {
        
        let seconds = time.calculateSecondsFrom()
        
        let pace = (seconds / distance).toMinuteSecondString()
    
        return pace
    }
    
}
