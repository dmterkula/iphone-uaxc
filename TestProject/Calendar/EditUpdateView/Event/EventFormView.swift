//
//  EventFormView.swift
//  UAXC
//
//  Created by David  Terkula on 11/13/22.
//

import SwiftUI

struct EventFormView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @ObservedObject var viewModel: EventFormViewModel
    var event: Event?
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    var body: some View {
        
        
        // then this is an ADD event
        if (event == nil) {
             
            // need to embed this in the form
            HStack {
                
                Text("Select Event Type")
                    .foregroundColor(.black)
                    .font(.title3)
                
                Picker(selection: $viewModel.type) {
                    ForEach(EventType.allCases, id: \.self.description) { value in
                        Text(value.description)
                            .tag(value.description)
                    }
                } label: {
                    Text("Event Type")
                        .font(.largeTitle)
                }
                .font(.largeTitle)
            }
           
            
            if (viewModel.type == EventType.workout.description) {
                WorkoutFormView(viewModel: WorkoutFormViewModel())
            } else if (viewModel.type == EventType.meet.description) {
                MeetEventFormView(viewModel: MeetEventFormViewModel())
            } else if(viewModel.type == EventType.training.description) {
                TrainingRunEventFormView(viewModel: TrainingRunEventFormViewModel())
            }
            
        } else {
            // this is an update event
        
            VStack {
                if (viewModel.type == EventType.workout.description) {
                    WorkoutFormView(viewModel: WorkoutFormViewModel((event as? WorkoutEvent)!.toWorkout()))
                } else if (viewModel.type == EventType.meet.description) {
                    MeetEventFormView(viewModel: MeetEventFormViewModel((event as? MeetEvent)!))
                } else if (viewModel.type == EventType.training.description) {
                    TrainingRunEventFormView(viewModel: TrainingRunEventFormViewModel((event as? TrainingRunEvent)!))
                }
            }
        }
    }
}

struct EventFormView_Previews: PreviewProvider {
    static var previews: some View {
        EventFormView(viewModel: EventFormViewModel())
            .environmentObject(EventStore())
    }
}
