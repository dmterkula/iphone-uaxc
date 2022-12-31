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
    
    var runner: String
    var season: String
    var goalType: String
    var goal: String
    @State var goalIsMet: Bool
    @State var metString = ""
    
    let dataService = DataService()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            let metString: String = goalIsMet ? "Yes" : "No"
            
            Text("Goal Type: " + goalType)
            Text("Goal: " + goal)
            Toggle("Has Met Goal: " + metString, isOn: $goalIsMet)
                .onChange(of: $goalIsMet.wrappedValue) { value in
                    upadteGoals(runner: runner, season: season, goalType: goalType, goal: goal, isMet: goalIsMet)
                }
        }
    }
    
    
    func upadteGoals(runner: String, season: String, goalType: String, goal: String, isMet: Bool) {
        
        let existingGoal = GoalElement(type: goalType, value: goal, met: !isMet)
        let updatedGoal = GoalElement(type: goalType, value: goal, met: isMet)
        
        dataService.updateGoalForRunner(runner: runner, season: season, existingGoal: existingGoal, updatedGoal: updatedGoal) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let goals):
                    print(goals)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
}

struct GoalsListView: View {
    
    @Binding var runner: Runner?
    @Binding var season: String
    @State var goalType: String = ""
    @State var goalValue: String = ""
    @State var goalIsMet = false
    @State var minutesValue: Int = 0
    @State var secondsValue: Int = 0
    @State var expandAddGoal: Bool = false
    @ObservedObject var goalsViewModel: GoalsViewModel
    @State var showSheet = false
    
    let dataService = DataService()
    let goalTypeOptions = ["Time", "Text"]
    
    func refreshGoalsForRunner(runnerId: Int, season: String) {
        dataService.fetchGoalsForRunnersV2(runnerId: runnerId, season: season) { (result) in
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
        dataService.deleteGoalForRunnerV2(runnerId: runner!.runnerId, season: goalToBeDeleted.season, goalElements: [GoalElement(type: goalToBeDeleted.type, value: goalToBeDeleted.value, met: goalToBeDeleted.met)]) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let goals):
                    self.refreshGoalsForRunner(runnerId: runner!.runnerId, season: season)
                
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
    
        VStack(alignment: .leading) {

            NavigationView {
                List {
                    ForEach(goalsViewModel.goals) { goal in
                        GoalRow(runner: runner!.name, season: season, goalType: goal.type, goal: goal.value, goalIsMet: goal.met)
                            
                    }
                    .onDelete(perform: deleteGoal)
                    .onMove(perform: moveGoal)
                }
                .environment(\.editMode, Binding.constant(EditMode.active))
                .listStyle(.plain)
            }
            .toolbar {
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                    .sheet(isPresented: $showSheet) {
                        RunnerGoalFormView(showSheet: $showSheet, runner: $runner, season: $season)
                            .preferredColorScheme(.light)
                    
                    }
                }
    
 
            }

            
        }// end top vstack
            
    }
}

//struct GoalsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalsListView()
//    }
//}
