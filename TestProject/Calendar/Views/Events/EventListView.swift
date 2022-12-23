//
//  WorkoutListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var myEvents: EventStore
    @EnvironmentObject var authentication: Authentication
    
    @State var filterForMeets = false
    @State var filterForTraining = false
    @State var filterForWorkouts = false
    
    @State private var formType: EventFormType?
    
    
    func filterEvents() -> [Event] {
        // if no filters or all filters, return all
        if ((!filterForMeets && !filterForTraining && !filterForWorkouts) || (filterForMeets && filterForWorkouts && filterForTraining)) {
            return myEvents.events
        } else {
           
            if (filterForMeets) {
                return myEvents.events.filter {$0.type.description == EventType.meet.description}
            }
            else if (filterForWorkouts) {
                return myEvents.events.filter {$0.type.description == EventType.workout.description}
            } else {
                // filter for training
                return myEvents.events.filter {$0.type.description == EventType.training.description}
            }
            
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Background().edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Text("UAXC Events")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, -1)
                        
                            .sheet(item: $formType) { $0 }
                        Spacer()
                        
                        if (authentication.user != nil && authentication.user!.role == "coach") {
                            Button {
                                formType = .new
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }.padding(.trailing, 10)
                        }
                    }
                    
                    EventFilter(filterForMeets: $filterForMeets, filterForWorkouts: $filterForWorkouts, filterForTraining: $filterForTraining)
                        .padding(.top, 6)
                        .padding(.bottom, 6)
                    
                    
                    
                    List {
                        ForEach(filterEvents().sorted {$0.date < $1.date }) { event in
                            
                            if (event.type == EventType.workout) {
                                WorkoutViewRow(workout: (event as? WorkoutEvent)!.toWorkout(), formType: $formType)
                                    .environmentObject(authentication)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: .destructive) {
                                                myEvents.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                            } else if (event.type == EventType.meet) {
                                MeetEventViewRow(meetEvent: (event as? MeetEvent)!, formType: $formType)
                                    .environmentObject(authentication)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: .destructive) {
                                                myEvents.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                            } else if (event.type == EventType.training) {
                                TrainingRunEventRow(trainingRunEvent: (event as? TrainingRunEvent)!, formType: $formType)
                                    .environmentObject(authentication)
                                    .swipeActions {
                                        if (authentication.user != nil && authentication.user!.role == "coach") {
                                            Button(role: .destructive) {
                                                myEvents.delete(event)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                            }

                        }
                    }
                    .frame(maxWidth: geometry.size.width * 0.95)
                    .sheet(item: $formType) { $0 }
                }
            }
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
            .environmentObject(EventStore(preview: true))
    }
}
