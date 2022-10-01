//
//  WorkoutFormView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutFormView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @StateObject var viewModel: WorkoutFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    DatePicker(selection: $viewModel.date, displayedComponents: [.date]) {
                        Text("Date")
                    }
                    HStack {
                        Text("Title: ")
                        TextField("Title", text: $viewModel.title, axis: .vertical)
                            .focused($focus, equals: true)
                    }
                   
                    HStack {
                        Text("Description")
                        TextField("Description: ", text: $viewModel.description, axis: .vertical)
                            .focused($focus, equals: true)
                    }
                   
                    Picker("Workout Type", selection: $viewModel.workoutType) {
                        ForEach(Workout.workoutTypes, id: \.self) {workoutType in
                            Text(workoutType)
                                .tag(workoutType)
                        }
                    }
                    if (viewModel.workoutType == "Interval") {
                        Picker("Interval Distance in meters", selection: $viewModel.targetDistance) {
                            ForEach(Workout.intervalDistances, id: \.self) {intDistance in
                                Text(String(intDistance))
                            }
                        }
                        
                        Picker("Interval Count", selection: $viewModel.targetCount) {
                            ForEach(Workout.intervalCounts, id: \.self) {intCount in
                                Text(String(intCount))
                            }
                        }
                        
                    
                    } else if (viewModel.workoutType == "Tempo") {
                        Picker("Tempo Duration (m)", selection: $viewModel.duration) {
                            ForEach(Workout.mintues, id: \.self) {minute in
                                Text(minute)
                            }
                        }
                    }
                          
                    Picker("Target Pace", selection: $viewModel.pace) {
                        ForEach(Workout.targetPaces, id: \.self) {pace in
                            Text(pace)
                        }
                    }
                    
                    Picker("Icon", selection: $viewModel.icon) {
                        ForEach(Workout.icons, id: \.self) {icon in
                            Text(icon + " " + Workout.getTextFromIcon(icon: icon))
                                .tag(icon)
                        }
                    }
                    
                    Section(footer:
                                HStack {
                        Spacer()
                        Button {
                            if viewModel.updating {
                                // update this event
                                let workout = Workout(
                                    date: viewModel.date,
                                    type: viewModel.workoutType,
                                    title: viewModel.title,
                                    description: viewModel.description,
                                    targetDistance: viewModel.targetDistance,
                                    targetCount: viewModel.targetCount,
                                    pace: viewModel.pace,
                                    duration: viewModel.duration,
                                    icon: viewModel.icon,
                                    uuid: viewModel.uuid
                                )
                                workoutStore.update(workout)
                            } else {
                                // create new event
                                let newWorkout =  Workout(
                                    date: viewModel.date,
                                    type: viewModel.workoutType,
                                    title: viewModel.title,
                                    description: viewModel.description,
                                    targetDistance: viewModel.targetDistance,
                                    targetCount: viewModel.targetCount,
                                    pace: viewModel.pace,
                                    duration: viewModel.duration,
                                    icon: viewModel.icon,
                                    uuid: viewModel.uuid
                                )
                                workoutStore.add(newWorkout)
                            }
                            dismiss()
                        } label: {
                            Text(viewModel.updating ? "Update Event" : "Add Event")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.incomplete)
                        Spacer()
                    }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Update" : "New Workout")
            .onAppear {
                focus = true
            }
        }
    }
}

struct WorkoutFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutFormView(viewModel: WorkoutFormViewModel())
            .environmentObject(WorkoutStore())
    }
}
