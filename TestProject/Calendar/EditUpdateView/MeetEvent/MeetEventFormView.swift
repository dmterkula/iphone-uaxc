//
//  MeetEventFormView.swift
//  UAXC
//
//  Created by David  Terkula on 11/13/22.
//

import SwiftUI

struct MeetEventFormView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @ObservedObject var viewModel: MeetEventFormViewModel
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
                        Text("Meet Name: ")
                        TextField("Meet", text: $viewModel.meetName, axis: .vertical)
                            .focused($focus, equals: true)
                    }
                    
                    Picker("Icon", selection: $viewModel.icon) {
                        ForEach(Workout.icons, id: \.self) {icon in
                            Text(icon + " " + Workout.getTextFromIcon(icon: icon))
                                .tag(icon)
                        }
                    }
                    
                    VStack {
                        MeetEventFormButtonSection(viewModel: viewModel)
                    }
                    
                    
                } // end form
            } // end navigation
            .navigationTitle(viewModel.updating ? "Update" : "New Meet")
            .onAppear {
                focus = true
                // initializeComponents()
            }
        }
    }
    
    struct MeetEventFormView_Previews: PreviewProvider {
        static var previews: some View {
            MeetEventFormView(viewModel: MeetEventFormViewModel())
        }
    }
    
    
    struct MeetEventFormButtonSection: View {
        
        
        @ObservedObject var viewModel: MeetEventFormViewModel
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
                        let meet = Meet(
                            name: viewModel.meetName,
                            date: viewModel.date,
                            icon: viewModel.icon,
                            uuid: viewModel.uuid.uuidString
                        )
                        eventStore.update(MeetEvent(meet: meet))
                    } else {
                        // create new event
                        let newMeet = Meet(
                            name: viewModel.meetName,
                            date: viewModel.date,
                            icon: viewModel.icon,
                            uuid: viewModel.uuid.uuidString
                        )
                        eventStore.add(MeetEvent(meet: newMeet))
                    }
                  
                } label: {
                    Text(viewModel.updating ? "Update Meet" : "Add Meet")
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
}
