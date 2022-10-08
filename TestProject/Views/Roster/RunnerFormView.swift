//
//  RunnerFormView.swift
//  UAXC
//
//  Created by David  Terkula on 10/4/22.
//

import SwiftUI

struct RunnerFormView: View {
    @EnvironmentObject var runnerStore: RunnerStore
    @StateObject var viewModel: RunnerFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    let dataService = DataService()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    
                    HStack {
                        Text("Name: ")
                        TextField("Name: ", text: $viewModel.name)
                    }
                    
                    HStack {
                        Text("Graduating Class: ")
                        TextField("Graduating Class: ", text: $viewModel.graduatingClass)
                    }
                    
                    Toggle("Active member of team", isOn: $viewModel.isActive)
                    
                    
                    Section(footer:
                                HStack {
                        Spacer()
                        Button {
                            
                            if (viewModel.updating) {
                                let runner = Runner(name: viewModel.name, graduatingClass: viewModel.graduatingClass, runnerId: Int(viewModel.id!)!, isActive: viewModel.isActive)
                                
                                runnerStore.update(runner)
                            } else {
                                let runner = Runner(name: viewModel.name, graduatingClass: viewModel.graduatingClass, runnerId: 0 , isActive: viewModel.isActive)
                                runnerStore.add(runner)
                            }
                        
                        } label: {
                            Text(viewModel.updating ? "Update Runner" : "Add Runner")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.incomplete)
                        
                        Spacer()
                        
                    }
                            
                    ) {
                        EmptyView()
                    } // end section
                   
                   
                                
                } // end form
            } // end navigation
            .navigationTitle(viewModel.updating ? "Update" : "New Runner")
            .onAppear {
                focus = true
            }
        }
    }
}
