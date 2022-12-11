//
//  EventFormType.swift
//  UAXC
//
//  Created by David  Terkula on 11/13/22.
//

import SwiftUI

enum EventFormType: Identifiable, View{
    case new
    case update(Event)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }

    var body: some View {
        switch self {
        case .new:
            return EventFormView(viewModel: EventFormViewModel()).preferredColorScheme(.light)
        case .update(let event):
            return EventFormView(viewModel: EventFormViewModel(event), event: event).preferredColorScheme(.light)
        }
    }
}
