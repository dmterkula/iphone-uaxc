//
//  TrainingRunEventRow.swift
//  UAXC
//
//  Created by David  Terkula on 11/25/22.
//

import SwiftUI

struct TrainingRunEventRow: View {
    
    let trainingRunEvent: TrainingRunEvent
    @EnvironmentObject var authentication: Authentication
    @Binding var formType: EventFormType?
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(trainingRunEvent.icon)
                        .font(.system(size: 30))
                    
                    VStack(alignment: .leading) {
                        Text(trainingRunEvent.title)
                            .font(.system(size: 30))
                        Text(
                            trainingRunEvent.date.formatted(date: .abbreviated,
                                                   time: .omitted))
                        }
                    
                    }
            }
            Spacer()
            VStack {
                
                if (authentication.user != nil && authentication.user!.role == "coach") {
                    Button {
                        formType = .update(trainingRunEvent)
                    } label: {
                        Text("Edit")
                    }
                    .buttonStyle(.bordered)
                }
                
                if (authentication.user != nil && authentication.user!.role == "coach") {
                    NavigationLink(destination: TrainingRunLandingPageCoachesView(trainingRunEvent: trainingRunEvent).environment(\.colorScheme, .light)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                } else if (authentication.user != nil && authentication.user!.role == "runner") {
                    NavigationLink(destination: TrainingRunLandingPageAthletesView(trainingRunEvent: trainingRunEvent, runner: authentication.runner!).environment(\.colorScheme, .light)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                }
                

            }.frame(maxWidth: 120)
        }
    }
}

struct TrainingRunEventRow_Previews: PreviewProvider {
    
    static let trainingRunEvent: TrainingRunEvent = TrainingRunEvent(trainingRun: TrainingRun(name: "Training Run", date: Date().diff(numDays: 4), icon: "👟", uuid: "962c7f4c-2079-40c9-ada1-02b45e3dcbee"))
    
    static var previews: some View {
        TrainingRunEventRow(trainingRunEvent: trainingRunEvent, formType: .constant(.new))
    }
    
}
