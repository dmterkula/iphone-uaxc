//
//  TrainingRunEventFormView.swift
//  UAXC
//
//  Created by David  Terkula on 11/26/22.
//

import SwiftUI

struct TrainingRunEventFormView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @ObservedObject var viewModel: TrainingRunEventFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    @State var distanceBased = true
    @State var timeBased = true
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    DatePicker(selection: $viewModel.date, displayedComponents: [.date]) {
                        Text("Date")
                    }
                    HStack {
                        Text("Title: ")
                        TextField("Training run", text: $viewModel.title, axis: .vertical)
                            .focused($focus, equals: true)
                    }
                    
                    Toggle("Set Target Distance", isOn: $distanceBased)
                    
                    if (distanceBased) {
                        VStack {
                            Slider(value: $viewModel.distance, in: 0...10, step: 0.5)
                            Text("Target Distance: " + String(((viewModel.distance)).rounded(toPlaces: 2)) + " Mi")
                        }
                    }
                    
                    Toggle("Set Duration", isOn: $timeBased)
                    
                  
                    if (timeBased) {
                        VStack {
                            Slider(value: $viewModel.duration, in: 0...90, step: 5)
                            Text("Target Duration: " + String(Int(viewModel.duration)) + " Minutes")
                        }
                        
                    }
                
                    Picker("Icon", selection: $viewModel.icon) {
                        ForEach(TrainingRun.icons, id: \.self) {icon in
                            Text(icon + " " + TrainingRun.getTextFromIcon(icon: icon))
                                .tag(icon)
                        }
                    }
                    
                    
                    VStack {
                        TrainingRunEventFormButtonSection(viewModel: viewModel)
                    }
                    
                } // end form
            } // end navigation
            .navigationTitle(viewModel.updating ? "Update" : "New Training Run")
            .onAppear {
                focus = true
            }
        }
    }
}

struct TrainingRunEventFormButtonSection: View {
    
    
    @ObservedObject var viewModel: TrainingRunEventFormViewModel
    @EnvironmentObject var eventStore: EventStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section(footer:
                    HStack {
            Spacer()
            Button {
                dismiss()
                if viewModel.updating {
                    // update this event
                    let trainingRun = TrainingRun(
                        name: viewModel.title,
                        date: viewModel.date,
                        time: viewModel.duration.minutesToMinuteString(),
                        distance: viewModel.distance,
                        icon: viewModel.icon,
                        uuid: viewModel.uuid.uuidString
                    )
                    
                    eventStore.update(TrainingRunEvent(trainingRun: trainingRun))
                } else {
                    // create new event
                    let trainingRun = TrainingRun(
                        name: viewModel.title,
                        date: viewModel.date,
                        time: viewModel.duration.minutesToMinuteString(),
                        distance: viewModel.distance,
                        icon: viewModel.icon,
                        uuid: viewModel.uuid.uuidString
                    )
                    
                    eventStore.add(TrainingRunEvent(trainingRun: trainingRun))
                }
              
            } label: {
                Text(viewModel.updating ? "Update Training Run" : "Add Training Run")
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


struct TrainingRunEventFormView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRunEventFormView(viewModel: TrainingRunEventFormViewModel())
    }
}
