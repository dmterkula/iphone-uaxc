//
//  RunnerGoalFormView.swift
//  UAXC
//
//  Created by David  Terkula on 12/30/22.
//

import SwiftUI

struct RunnerGoalFormView: View {
    
    @Binding var showSheet: Bool
    @Binding var runner: Runner?
    @Binding var season: String
    
    
    let dataService = DataService()
    
    @ObservedObject var viewModel: RunnerGoalFormViewModel = RunnerGoalFormViewModel()
    
    func addRunnersGoal() {
        
    }
    
    var body: some View {
        VStack {
            
            Text("Add Goal")
            
            Form {
                
                Section(header: Text("Select Goal Type")) {
                    Menu {
                        Picker("Selected Goal Type: " + viewModel.goalType, selection: $viewModel.goalType, content: {
                            ForEach(viewModel.goalTypeOptions, id: \.self, content: { goalType in
                                Text(goalType).foregroundColor(.white)
                            })
                        })
                        .pickerStyle(MenuPickerStyle())
                        .labelsHidden()
                    } label: {
                        Text("Select goal type: " + viewModel.goalType)
                            .foregroundColor(.black)
                    }

                }
                
                Section(header: Text("Set Goal")) {
                    if (viewModel.goalType == "Time") {
                        RaceTimePicker(minutesValue: $viewModel.minutesValue, secondsValue: $viewModel.secondsValue)
                            .frame(height: 20)
                    } else {
                        TextField("Goal: ", text: $viewModel.goalValue)
                    }
                }
                
                Section(header: Text("Met the goal?")) {
                    Toggle("Goal is met: ", isOn: $viewModel.goalIsMet)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                
                Section(header: Text("Add goal")) {
                    
                    Button(action: {
                        hideKeyboard()
                    
                        dataService.createGoalForRunnerV2(runnerId: runner!.runnerId, season: season, goalElements: [GoalElement(type: viewModel.goalType, value: viewModel.getGoalString(), met: viewModel.goalIsMet)]) { (result) in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    print(response)
                                    showSheet.toggle()
                                    case .failure(let error):
                                        print(error)
                                }
                            }
                        }
                    
                       
                    }, label: {
                        Text("Add Goal")
                            .bold()
                            .frame(width: 200, height: 50, alignment: .center)
                            .background(.green)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        
                    })
                }
                
            }
        }
        
    }
}

//struct RunnerGoalFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerGoalFormView()
//    }
//}
