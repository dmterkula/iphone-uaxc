//
//  DaysWorkoutsListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct DaysEventsListView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var authentication: Authentication
    @Binding var dateSelected: DateComponents?
    @State private var formType: EventFormType?
    
    
    var body: some View {
        NavigationStack {
            Group {
                if let dateSelected {
                    let foundEvents = eventStore.events.filter {
                        $0.date.startOfDay == dateSelected.date!.startOfDay
                    }
                    
                    List {
                        ForEach(foundEvents) { event in
                            if (event.type == EventType.workout) {
                                WorkoutViewRow(workout: (event as? WorkoutEvent)!.toWorkout(), formType: $formType)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: . destructive) {
                                                eventStore.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                                    .sheet(item: $formType) { $0 }
                            } else if (event.type == EventType.meet) {
                                MeetEventViewRow(meetEvent: (event as? MeetEvent)!, formType: $formType)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: . destructive) {
                                                eventStore.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                                    .sheet(item: $formType) { $0 }
                            } else if(event.type == EventType.training) {
                                TrainingRunEventRow(trainingRunEvent: (event as? TrainingRunEvent)!, formType: $formType)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: .destructive) {
                                                eventStore.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                            }

                        }
                    }
                    
                }
            }
        }.navigationTitle(dateSelected?.date?.formatted(date: .long, time: .omitted) ?? "")
    }
}

struct DaysWorkoutsListView_Previews: PreviewProvider {
    
    static var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    static var previews: some View {
        DaysEventsListView(dateSelected: .constant(dateComponents))
            .environmentObject(EventStore(preview: true))
    }
}
