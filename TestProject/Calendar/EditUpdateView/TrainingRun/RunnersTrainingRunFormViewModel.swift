//
//  RunnersTrainingRunFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 12/1/22.
//

import Foundation

class RunnersTrainingRunFormViewModel: ObservableObject, Identifiable {
    
    var runner: Runner
    var trainingRunUuid: String
    
    var id = UUID()
    var uuid: String = UUID().uuidString
    @Published
    var time: String = "00:00"
    @Published
    var distance: Double = 0.0
    @Published
    var avgPace: String = "00:00"
    
    @Published
    var wholeMiles: Int =  0
    
    @Published
    var fractionMiles: Int = 0
    
    @Published
    var minutes: Int = 0
    
    @Published
    var seconds: Int = 0
    
    
    init() {
        self.runner = Runner(name: "test", graduatingClass: "test", isActive: false)
        self.trainingRunUuid = ""
    }
    
    init(runner: Runner, trainingRunUuid: String) {
        self.runner = runner
        self.trainingRunUuid = trainingRunUuid
    }
    
    init(_ trainingRunResultDTO: TrainingRunResultDTO) {
        self.uuid = trainingRunResultDTO.uuid
        self.runner = trainingRunResultDTO.runner
        self.trainingRunUuid = trainingRunResultDTO.trainingRunUuid
        self.time = trainingRunResultDTO.time
        self.distance = trainingRunResultDTO.distance
        self.avgPace = trainingRunResultDTO.avgPace
        
        if (time != "00:00") {
            minutes = GlobalFunctions.getMinutesValueFromMinuteSecondString(time: self.time)
            seconds = GlobalFunctions.getSecondsValueFromMinuteSecondString(time: self.time)
        }
        
        if (distance != 0.0) {
            wholeMiles = Int(distance)
            fractionMiles = Int((distance - Double(wholeMiles)) * 100.0)
        }
   }
    
    func getTimeString() -> String {
        
        var minuteString = ""
        var secondString = ""
        
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
        
        return minuteString + ":" + secondString
        
    }
    
    func calcDistance() -> Double {
        return Double(Double(wholeMiles) + Double(Double(fractionMiles)/100.0))
    }
    
    func isComplete() -> Bool {
        return (wholeMiles != 0 || fractionMiles != 0) && (minutes != 00 || seconds != 0)
    }
    
    func calcAveragePace() -> String {
        if (wholeMiles != 0 && minutes != 0 ) {
            return GlobalFunctions.getPacePerMile(time: getTimeString(), distance: Double(Double(wholeMiles) + Double(Double(fractionMiles)/100.0)))
        } else {
            return "00:00"
        }
    }
     
}
