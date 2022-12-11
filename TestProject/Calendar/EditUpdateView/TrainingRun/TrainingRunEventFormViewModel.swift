//
//  TrainingRunEventFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 11/26/22.
//

import Foundation

class TrainingRunEventFormViewModel: ObservableObject {
    
    @Published var date = Date()
    @Published var title: String = ""
    @Published var uuid: UUID = UUID()
    @Published var icon: String = "📌"
    @Published var distance: Double = 0.0
    @Published var time: String = "00:00"
    @Published var duration: Double = 0.0

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ trainingRunEvent: TrainingRunEvent) {
        self.date = trainingRunEvent.date
        self.title = trainingRunEvent.title
        self.id = trainingRunEvent.id.uuidString
        self.uuid = UUID(uuidString: trainingRunEvent.uuid)!
        self.icon = trainingRunEvent.icon
        self.distance = trainingRunEvent.distance ?? 0.0
        self.time = trainingRunEvent.time ?? "00:00"
        
        if (self.time != "00:00") {
            self.duration = self.time.calculateSecondsFrom() / 60
        }
        
    }
    
    var incomplete: Bool {
        return !(distance != 0.0 || duration != 0.0)
    }
}
