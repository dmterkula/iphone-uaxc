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
    
    @State private var formType: EventFormType?
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
                    
                    
                    List {
                        ForEach(myEvents.events.sorted {$0.date < $1.date }) { event in
                            
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
            .environmentObject(WorkoutStore(preview: true))
    }
}
