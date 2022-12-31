//
//  RunnerGoalFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 12/30/22.
//

import Foundation

class RunnerGoalFormViewModel: ObservableObject {
    
    @Published var goalType: String = "Time"
    @Published var goalValue: String = ""
    @Published var goalIsMet = false
    @Published var minutesValue: Int = 0
    @Published var secondsValue: Int = 0
    
    let goalTypeOptions = ["Time", "General"]
    
    func getGoalString() -> String {
        if (self.goalType == "Time") {
            if (self.secondsValue < 10) {
                return String(self.minutesValue) + ":0" + String(self.secondsValue)
            } else {
                return String(self.minutesValue) + ":" + String(self.secondsValue)
            }
            
        } else {
            return self.goalValue
        }
    }
    
}
