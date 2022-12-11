////
////  MeetViewRow.swift
////  UAXC
////
////  Created by David  Terkula on 11/13/22.
////
//
import SwiftUI

struct MeetEventViewRow: View {
    let meetEvent: MeetEvent
    @EnvironmentObject var authentication: Authentication

    @Binding var formType: EventFormType?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(meetEvent.icon)
                        .font(.system(size: 30))

                    VStack(alignment: .leading) {
                        Text(meetEvent.title)
                            .font(.system(size: 30))
                        Text(
                            meetEvent.date.formatted(date: .abbreviated,
                                                   time: .omitted))
                        }

                    }
            }
            Spacer()
            VStack {

                if (authentication.user != nil && authentication.user!.role == "coach") {
                    Button {
                        formType = .update(meetEvent)
                    } label: {
                        Text("Edit")
                    }
                    .buttonStyle(.bordered)
                }
                
                NavigationLink(destination: GetMeetSummaryView(season: meetEvent.date.getYear(), meetName: meetEvent.title)) {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
            }.frame(maxWidth: 120)
        }

    }
}

 struct MeetEventViewRow_Previews: PreviewProvider {
     static let workout =  Workout(date: Date().diff(numDays: 4), title: "800m repeats", description: "6-7x 800s at goal pace",  icon: "🦁", uuid: UUID.init(uuidString: "962c7f4c-2079-40c9-ada1-02b45e3dcbee")!, components:  [WorkoutComponent(description: "6-7x 800s at goal pace", type: "Interval", pace: "goal", targetDistance: 800, targetCount: 6, duration: "", targetPaceAdjustment: "", uuid: UUID.init(uuidString: "259a8fc3-0ae7-42fd-b141-0c13f840651c")!)])
    static var previews: some View {
        WorkoutViewRow(workout: workout, formType: .constant(.new))
    }
 }

