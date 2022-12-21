//
//  MeetEvent.swift
//  UAXC
//
//  Created by David  Terkula on 12/18/22.
//

import Foundation

class MeetEvent: Event {
    init (meet: Meet) {
        super.init(
            title: meet.name,
            date: meet.date,
            description: nil,
            icon: meet.icon,
            uuid: meet.uuid,
            type: EventType.meet
        )
    }
}
