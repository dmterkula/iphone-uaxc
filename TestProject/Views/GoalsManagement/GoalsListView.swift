//
//  GoalsListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/15/22.
//

import SwiftUI

class GoalsViewModel: ObservableObject {
    @Published var goals = [GoalsDTO]()
}

struct GoalRow: View {
    
    var goalType: String
    var goal: String
    var goalIsMet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            let metString: String = goalIsMet ? "Yes" : "No"
            
            Text("Goal Type: " + goalType)
            Text("Goal: " + goal)
            Text("Has been met: " + metString)
        }
    }
}

struct GoalsListView: View {
    
    @Binding var runnerName: String
    @Binding var season: String
    @State var goalType: String = ""
    @State var goalValue: String = ""
    @State var goalIsMet = false
    @State var minutesValue: Int = 0
    @State var secondsValue: Int = 0
    @ObservedObject var goalsViewModel: GoalsViewModel
    
    let dataService = DataService()
    let goalTypeOptions = ["Time", "Text"]
    
    func refreshGoalsForRunner(name: String, season: String) {
        dataService.fetchGoalsForRunners(runner: name, season: season) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let goals):
                    goalsViewModel.goals.removeAll()
                    goalsViewModel.goals.append(contentsOf: goals.goals)
                
                    case .failure(let error):
                        print(error)
                }
            }
            
        }
    }
    
    func deleteGoal(offsets: IndexSet) {
        
        let goalToBeDeleted: GoalsDTO = goalsViewModel.goals[offsets.first!]
        dataService.deleteGoalForRunner(runner: runnerName.components(separatedBy: ":")[0], season: goalToBeDeleted.season, goalElements: [GoalElement(type: goalToBeDeleted.type, value: goalToBeDeleted.value, met: goalToBeDeleted.met)]) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let goals):
                    self.refreshGoalsForRunner(name: runnerName.components(separatedBy: ":")[0], season: season)
                
                    case .failure(let error):
                        print(error)
                }
            }
            
        }
        
    }
    
    func moveGoal(source: IndexSet, destination: Int) {
        goalsViewModel.goals.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
    
        VStack {
            Text("Add New Goal")
            .font(.title2)
            
            Menu {
                Picker("Selected Goal Type: " + goalType, selection: $goalType, content: {
                    ForEach(goalTypeOptions, id: \.self, content: { goalType in
                        Text(goalType).foregroundColor(.white)
                    })
                })
                .pickerStyle(MenuPickerStyle())
                .accentColor(.white)
                .labelsHidden()
            } label: {
                Text("Select goal type: " + goalType)
                    .foregroundColor(.white)
                    .font(.title2)
            }
            
            if (goalType == "Time") {
                TimePicker(minutesValue: $minutesValue, secondsValue: $secondsValue)
                    .frame(height: 20)
            } else {
                TextField("Goal: ", text: $goalValue)
            }
            
            Toggle("Goal is met: ", isOn: $goalIsMet)
                .padding(.bottom, 10)
                .onTapGesture {
                    hideKeyboard()
                }
                
            Button(action: {
                hideKeyboard()
                var goalString = goalValue
                
                if (goalType == "Time") {
                    if (secondsValue < 10) {
                        goalString = String(minutesValue) + ":0" + String(secondsValue)
                    } else {
                        goalString = String(minutesValue) + ":" + String(secondsValue)
                    }
                    
                }
                
                if (!runnerName.isEmpty && !season.isEmpty && !goalType.isEmpty && goalString != "0:0") {
                    
                    
                    dataService.createGoalForRunner(runner: runnerName.components(separatedBy: ":")[0], season: season, goalElements: [GoalElement(type: goalType, value: goalString, met: goalIsMet)]) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                print(response)
                                self.refreshGoalsForRunner(name: runnerName.components(separatedBy: ":")[0], season: season)
                                case .failure(let error):
                                    print(error)
                            }
                        }
                    }
                } else {
                    print("not all values provided")
                }
               
            }, label: {
                Text("Add Goal")
                    .bold()
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(.green)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                
            })
            .onTapGesture {
                
            }
            
            GeometryReader {geometry in
                HStack {
                    Spacer()
                    List {
                        ForEach(goalsViewModel.goals) { goal in
                            GoalRow(goalType: goal.type, goal: goal.value, goalIsMet: goal.met)
                                
                        }
                        .onDelete(perform: deleteGoal)
                        .onMove(perform: moveGoal)
                    }
                    .environment(\.editMode, Binding.constant(EditMode.active))
                    .frame(width: geometry.size.width * 0.95)
                    .listStyle(.plain)
                    
                    
                    Spacer()
                }
               
            }
            
        
        } // end top vstack
    }
}

//struct GoalsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalsListView()
//    }
//}
