//
//  EventFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 11/13/22.
//

import Foundation

class EventFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var title = ""
    @Published var description: String = ""
    @Published var uuid: UUID = UUID()
    @Published var icon: String = "📌"
    @Published var type: String = EventType.workout.description

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ event: Event) {
        self.date = event.date
        self.title = event.title
        self.id = event.id.uuidString
        self.description = event.description ?? ""
        self.uuid = UUID(uuidString: event.uuid)!
        self.icon = event.icon
        self.type = event.type.description
    }
    
    var incomplete: Bool {
        title.isEmpty
    }
}
