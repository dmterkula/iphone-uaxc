//
//  RunnerWorkoutEditFormView.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import SwiftUI

struct RunnerWorkoutEditFormView: View {
    
    var workout: Workout
    
    let dataService = DataService()
    
    @EnvironmentObject var authentication: Authentication
    
    @Binding var viewModel: RunnerWorkoutFormViewModel
    
    @StateObject var editingViewModel: EditingRunnerWorkoutFormViewModel = EditingRunnerWorkoutFormViewModel()
    
    @Binding var showEditSheet: Bool

    
    func getUuidStringToSplits() -> [String: [Split]] {
        
        var returnMe: [String: [Split]] = Dictionary(uniqueKeysWithValues: viewModel.componentToSplits.map { ($0.key.uuid.uuidString, $0.value.toSplits())})
        
        return returnMe
        
    }
    
    func updateDB() {
        dataService.logRunnersWorkoutResults(runnerId: authentication.runner!.runnerId, workoutUuid: workout.uuid.uuidString, totalDistance: viewModel.totalDistance, componentUuidToSplits: getUuidStringToSplits()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    print(results)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationStack() {
            
            Text("Your Workout Details")
                .toolbar {
                    ToolbarItemGroup() {
                        Button("Cancel") {
                            showEditSheet = false
                        }

                        Button("Save") {
                            viewModel.totalDistance = Double(editingViewModel.miles) + Double(editingViewModel.fractionOfMiles) / 100.0
                            viewModel.componentToSplits = editingViewModel.componentToSplits
                            
                            updateDB()
                            
                            showEditSheet = false
                        }
                    }
                }
            
            Form {
                Section {
                    Text("Distance Run")
                    MilesPicker(miles: $editingViewModel.miles, fractionOfMiles: $editingViewModel.fractionOfMiles, label: "Miles: ")
                }
                
                ForEach(Array(editingViewModel.componentToSplits.keys), id: \.self) { key in
                    Section(header:
                        NavigationLink(destination: WorkoutComponentSplitsView(
                            overallViewModel: editingViewModel, key: key)) {
                            Text("Edit Splits")
                        }
                            )
                    {
                        Text(key.description)
                        ForEach(editingViewModel.componentToSplits[key]!) { splitViewModel in
                            SplitRow(number: splitViewModel.number, time: splitViewModel.getMinuteSecondString())
                        }

                    } // section body
                    .textCase(nil)
                }
            }
        }.onAppear {
            editingViewModel.componentToSplits = EditingRunnerWorkoutFormViewModel(viewModel).componentToSplits
            editingViewModel.totalDistance = EditingRunnerWorkoutFormViewModel(viewModel).totalDistance
            editingViewModel.miles = Int(viewModel.totalDistance)
            editingViewModel.fractionOfMiles = Int((viewModel.totalDistance - Double(editingViewModel.miles)) * 100)
            
        }
        
       
    }
}

//struct RunnerWorkoutEditFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerWorkoutEditFormView()
//    }
//}
