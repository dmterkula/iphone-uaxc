//
//  WorkoutViewRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutViewRow: View {
    let workout: Workout
    @Binding var formType: WorkoutFormType?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(workout.icon)
                        .font(.system(size: 30))
                    
                    VStack(alignment: .leading) {
                        Text(workout.title)
                            .font(.system(size: 30))
                        Text("Pace: " + workout.pace)
                        Text(
                            workout.date.formatted(date: .abbreviated,
                                                   time: .omitted))
                        }
                    
                    }
            }
            Spacer()
            VStack {
                Button {
                    formType = .update(workout)
                } label: {
                    Text("Edit")
                }
                .buttonStyle(.bordered)
                
                NavigationLink(destination: WorkoutPlanView(workout: workout).environment(\.colorScheme, .light)) {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
            }.frame(maxWidth: 120)
        }

    }
}

 struct WorkoutViewRow_Previews: PreviewProvider {
     static let workout = Workout(date: Date().diff(numDays: 0), type: "Interval", title: "800m repeats", description: "800m repeats @ goal pace", targetDistance: 800, targetCount: 6, pace: "Goal", duration: "", icon: "🦁", uuid: UUID.init(uuidString: "962c7f4c-2079-40c9-ada1-02b45e3dcbee")!)
    static var previews: some View {
        WorkoutViewRow(workout: workout, formType: .constant(.new))
    }
 }
