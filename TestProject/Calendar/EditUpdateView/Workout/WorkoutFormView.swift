//
//  WorkoutFormView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutFormView: View {
    @EnvironmentObject var eventStore: EventStore
    @ObservedObject var viewModel: WorkoutFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    @State var sliderValue: Int = 0

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
                    
                    Picker("Icon", selection: $viewModel.icon) {
                        ForEach(Workout.icons, id: \.self) {icon in
                            Text(icon + " " + Workout.getTextFromIcon(icon: icon))
                                .tag(icon)
                        }
                    }
                   
                    List {
                        ForEach(viewModel.components) { component in
                            Section {
                               
                                HStack {
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.components.removeAll { $0.uuid == component.uuid }
                                    } label: {
                                        Image(systemName: "minus")
                                            .imageScale(.large)
                                    }.padding(.trailing, 5)
                                }
                                
                                WorkoutComponentFormView(viewModel: component)
                                
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            
                            Spacer()
                            
                            Button() {
                                viewModel.addComponent()
                            } label: {
                                Text("Add another component")
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                        }.padding(.bottom, 5)
                        
                        
                        WorkoutFormButtonSection(viewModel: viewModel)
                    }
                    
                  
                } // end form
            } // end navigation
            .navigationTitle(viewModel.updating ? "Update" : "New Workout")
            .onAppear {
                focus = true
                // initializeComponents()
            }
        }
    }
}

struct WorkoutFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutFormView(viewModel: WorkoutFormViewModel())
            .environmentObject(EventStore())
    }
}

struct WorkoutComponentFormView: View {
    
    @ObservedObject var viewModel: WorkoutComponentFormViewModel
    @FocusState private var focus: Bool?
    @State var displayInMiles: Bool = false
    
    var body: some View {
        
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
            VStack {
                Slider(value: IntDoubleBinding($viewModel.targetDistance).doubleValue, in: 100...5000, step: 1)
                
                HStack {
                    let buttonTextMi = "(Miles)"
                    let buttonTextMeter = "(Meters)"
                    Button() {
                        displayInMiles.toggle()
                    } label : {
                        if (displayInMiles) {
                            Text(buttonTextMi)
                        } else {
                            Text(buttonTextMeter)
                        }
                    }
                    .padding(.trailing, 10)
                    
                    if (displayInMiles) {
                        Text("Target Distance: " + String((Double(viewModel.targetDistance) / 1609.0).rounded(toPlaces: 2)) + " Mi")
                    } else {
                        Text("Target Distance: " + String(viewModel.targetDistance) + "m")
                    }
                        
                }
            }
            
            Picker("Interval Count", selection: $viewModel.targetCount) {
                ForEach(Workout.intervalCounts, id: \.self) {intCount in
                    Text(String(intCount))
                }
            }
            
        
        } else if (viewModel.workoutType == "Tempo") {
            
            VStack {
                Slider(value: IntDoubleBinding($viewModel.targetDistance).doubleValue, in: 1609...11263, step: 402)
                Text("Target Distance: " + String((Double(viewModel.targetDistance) / 1609.0).rounded(toPlaces: 2)) + " Mi")
            }
            
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
        
        VStack {
            Slider(value: $viewModel.paceAdjustmentRaw, in: -120...120, step: 1)
            Text("Target Pace Adjusted By: " + $viewModel.paceAdjustmentRaw.wrappedValue.toMinuteSecondString())
        }
    
    }
    
}

struct WorkoutFormButtonSection: View {
    
    @ObservedObject var viewModel: WorkoutFormViewModel
    // @Binding var workoutComponents: [WorkoutComponentFormViewModel]
    @EnvironmentObject var eventStore: EventStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section(footer:
                    HStack {
            Spacer()
            Button {
                if viewModel.updating {
                    // update this event
                    let workout = Workout(
                        date: viewModel.date,
                        title: viewModel.title,
                        description: viewModel.description,
                        icon: viewModel.icon,
                        uuid: viewModel.uuid,
                        components: viewModel.components.map { WorkoutComponent (
                            description: $0.description,
                            type: $0.workoutType,
                            pace: $0.pace,
                            targetDistance: $0.targetDistance,
                            targetCount: $0.targetCount,
                            duration: $0.duration,
                            targetPaceAdjustment: $0.paceAdjustmentRaw.toMinuteSecondString(),
                            uuid: $0.uuid) }
                    )
                    eventStore.update(WorkoutEvent(workout: workout))
                } else {
                    // create new event
                    let newWorkout =  Workout(
                        date: viewModel.date,
                        title: viewModel.title,
                        description: viewModel.description,
                        icon: viewModel.icon,
                        uuid: viewModel.uuid,
                        components: viewModel.components.map { WorkoutComponent (
                            description: $0.description,
                            type: $0.workoutType,
                            pace: $0.pace,
                            targetDistance: $0.targetDistance,
                            targetCount: $0.targetCount,
                            duration: $0.duration,
                            targetPaceAdjustment: $0.paceAdjustmentRaw.toMinuteSecondString(),
                            uuid: $0.uuid) }
                    )
                    eventStore.add(WorkoutEvent(workout: newWorkout))
                }
                dismiss()
            } label: {
                Text(viewModel.updating ? "Update Workout" : "Add Workut")
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.incomplete)
            Spacer()
        }
        ) {
            EmptyView()
        } // end section
    }
    
}
