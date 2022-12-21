//
//  LogTrainingRunFormView.swift
//  UAXC
//
//  Created by David  Terkula on 12/1/22.
//

import SwiftUI

struct LogTrainingRunFormView: View {
    
    @Binding var viewModel: RunnersTrainingRunFormViewModel
    let dataService = DataService()
    
    @StateObject
    var editingViewModel: RunnersTrainingRunFormViewModel = RunnersTrainingRunFormViewModel()
    
    @Binding var showEditSheet: Bool
    
    @EnvironmentObject var authentication: Authentication
    
    func getTitle() -> String {
        if(authentication.user!.role == "coach") {
            if(viewModel.runner.name.last! == "s") {
                return "Edit " + viewModel.runner.name + "' run"
            } else {
                return "Edit " + viewModel.runner.name + "'s run"
            }
           
        } else {
            return "Log your run"
        }
    }
    
    func updateDB() {
        dataService.logTrainingRun(viewModel: viewModel) { (result) in
              DispatchQueue.main.async {
                  switch result {
                  case .success(let response):
                          print(response)

                      case .failure(let error):
                          print(error)
                  }
              }
          }
    }
    
    var body: some View {
        
        NavigationStack() {
            Text(getTitle())
                .toolbar {
                    ToolbarItemGroup() {
                        Button("Cancel") {
                            showEditSheet = false
                        }

                        Button("Save") {
                            viewModel = editingViewModel
                            
                            updateDB()
                            
                            showEditSheet = false
                        }
                        .disabled(!editingViewModel.isComplete())
                    }
                }
            
            Form {
                
                Section(header: Text("Distance")) {
                    MilesPicker(miles: $editingViewModel.wholeMiles, fractionOfMiles: $editingViewModel.fractionMiles, label: "Miles: ")
                }
                
                Section(header: Text("Time")) {
                    TrainingRunTimePicker(minutes: $editingViewModel.minutes, seconds: $editingViewModel.seconds)
                }
                
                Section(header: Text("Avg. Pace Per Mi")) {
                    HStack {
                        Text(editingViewModel.calcAveragePace())
                    }
                }
            }
            
            
        }.onAppear {
            editingViewModel.runner = viewModel.runner
            editingViewModel.trainingRunUuid = viewModel.trainingRunUuid
            editingViewModel.wholeMiles = viewModel.wholeMiles
            editingViewModel.fractionMiles = viewModel.fractionMiles
            editingViewModel.minutes = viewModel.minutes
            editingViewModel.seconds = editingViewModel.seconds
            editingViewModel.avgPace = viewModel.calcAveragePace()
            editingViewModel.distance = viewModel.calcDistance()
        }
       
        
    
    }
}

//struct LogTrainingRunFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogTrainingRunFormView()
//    }
//}
