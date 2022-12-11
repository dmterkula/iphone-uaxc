//
//  MeetEventFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 11/13/22.
//

import Foundation

class MeetEventFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var meetName = ""
    @Published var uuid: UUID = UUID()
    @Published var icon: String = "📌"

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ meetEvent: MeetEvent) {
        self.date = meetEvent.date
        self.meetName = meetEvent.title
        self.id = meetEvent.id.uuidString
        self.uuid = UUID(uuidString: meetEvent.uuid)!
        self.icon = meetEvent.icon
    }
    
    var incomplete: Bool {
        return meetName.isEmpty
    }
}
