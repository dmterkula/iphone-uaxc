//
//  TrainingRunEvent.swift
//  UAXC
//
//  Created by David  Terkula on 12/18/22.
//

import Foundation

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
