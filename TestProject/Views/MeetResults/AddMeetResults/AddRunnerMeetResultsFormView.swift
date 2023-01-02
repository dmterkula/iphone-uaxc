//
//  AddRunnerMeetResultsFormView.swift
//  UAXC
//
//  Created by David  Terkula on 12/31/22.
//

import SwiftUI

struct AddRunnerMeetResultsFormView: View {
    
    @Binding var showSheet: Bool
    @Binding var season: String
    @Binding var meet: String
    @Binding var runners: [Runner]
    @State var runner: Runner?
    @State var runnerName: String
    @ObservedObject var viewModel: AddRunnerMeetResultFormViewModel
    
    let dataService = DataService()
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Runner")) {
                    RunnerPickerViewLight(runners: $runners, runnerLabel: $runnerName)
                        .onChange(of: runnerName) { newValue in
                            runner = runners.first { $0.name == runnerName.components(separatedBy: ":")[0]}!
                            viewModel.runner = runner
                        }
                }
                
                Section(header: Text("Time")) {
                    
                    VStack {
                        RaceTimePickerMillis(minutesValue: $viewModel.minutes, secondsValue: $viewModel.seconds, millisecondsValue: $viewModel.milliseconds)
                            .frame(minHeight: 50)
                    }
                    
                }
                
                Section(header: Text("Place")) {
                    PlacePicker(place: $viewModel.place)
                }
            }
            
            Group {
                Section(header: Text("Mile 1 Split")) {
                    SplitTimePickerLight(minutesValue: $viewModel.mileOneMinutes, secondsValue: $viewModel.mileOneSeconds)
                        .frame(minHeight: 40)
                }
                
                Section(header: Text("Mile 2 Split")) {
                    SplitTimePickerLight(minutesValue: $viewModel.mileTwoMinutes, secondsValue: $viewModel.mileTwoSeconds)
                        .frame(minHeight: 40)
                }
                
                Section(header: Text("Mile 3 Split")) {
                    SplitTimePickerLight(minutesValue: $viewModel.mileThreeMinutes, secondsValue: $viewModel.mileThreeSeconds)
                        .frame(minHeight: 40)
                }
            }
           
            Group {
                Section(header: Text("Passes Second Mile")) {
                    PassesPicker(passes: $viewModel.passesSecondMile)
                }
                
                Section(header: Text("Passes Last Mile")) {
                    PassesPicker(passes: $viewModel.passesLastMile)
                }
                
                Section(header: Text("Skull beads earned")) {
                    SkullBeadPicker(skulls: $viewModel.skullsEarned)
                }
            }
            
            Group {
                Section(header: Text("Save Result")) {
                    Button() {
                        
                        let request = CreateRunnersTotalMeetResultsRequest(season: season, runnerId: viewModel.runner!.runnerId, meetName: meet, time: viewModel.getTimeString(), place: viewModel.place, passesLastMile: viewModel.passesLastMile, passesSecondMile: viewModel.passesSecondMile, skullsEarned: viewModel.skullsEarned, mileOneSplit: viewModel.getMileOneSplitString(), mileTwoSplit: viewModel.getMileTwoSplitString(), mileThreeSplit: viewModel.getMileThreeSplitString())
                        
                        dataService.createRunnersTotalMeetResults(createRunnerResultsRequest: request) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    print(response)
                                    showSheet = false
                                    case .failure(let error):
                                        print(error)
                                        print(error)
                                }
                            }
                        }
                        
                    } label: {
                        Text("Save Result")
                    }
                    .disabled(!viewModel.isComplete())
                }
            }
            
        }
    }
}



//struct AddRunnerMeetResultsFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRunnerMeetResultsFormView()
//    }
//}
