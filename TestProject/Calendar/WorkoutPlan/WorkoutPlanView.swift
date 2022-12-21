//
//  WorkoutPlanView.swift
//  UAXC
//
//  Created by David  Terkula on 9/27/22.
//

import SwiftUI

struct WorkoutPlanView: View {

    var workout: Workout
    let dataService = DataService()
    
    @State var workoutPlanDisclosureGroupisExpanded: Bool = false
    
    @State var workoutPlanResponse: WorkoutPlanResponse?
    
    @State var showRunnerPlans: Bool = true
    
    func fetchWorkoutPlan() {
        
        dataService.getWorkoutPlan(workout: workout) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    workoutPlanResponse = response
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Background().edgesIgnoringSafeArea(.all)
                    .onAppear {
                        fetchWorkoutPlan()
                    }
                    VStack {
                        VStack {
                            Text(workout.date.formatted(date: .abbreviated,
                                                        time: .omitted))
                            .foregroundColor(.white)
                            Text(workout.title)
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text(workout.title)
                                .font(.title3)
                                .foregroundColor(.white)
                          
                        }.padding(.bottom, 10)
                       
                        HStack {
                            
                            Spacer()
                            
                            Button() {
                                showRunnerPlans.toggle()
                            } label: {
                                if (showRunnerPlans) {
                                    Text("Show By Component")
                                        .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                } else {
                                    Text("Show By Runner")
                                        .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                                }
                            }
                            
                            Spacer()
                            
                        }.padding(.bottom, 10)
                        
                        if (workoutPlanResponse != nil) {
                            
                            HStack {
                                Spacer()
                                
                                if (showRunnerPlans) {
                                    
                                    
                                    Form {
                                        ForEach(workoutPlanResponse!.runnerWorkoutPlans) { runnerPlan in
                                            Section() {
                                                    RunnerWorkoutPlanRow(runnerWorkoutPlan: runnerPlan)
                                                        .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                                }
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.90)
                                } else {
            
                                    List {
                                        ForEach(workoutPlanResponse!.componentsToWorkoutPlans) { compPlan in
                                            WorkoutComponentPlanRowView(workoutComponentPlan: compPlan)
                                                .listRowBackground(Color(red: 196/255, green: 207/255, blue: 209/255))
                                        }
                                    }
                                    .frame(width: geometry.size.width * 0.90)
            
                                    
                                }
                                
                                Spacer()
                            }
                        }
                        
                    }
            }// end zstack

        }// end geometry
    }

}


struct WorkoutPlanView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlanView(workout: (Workout.sampleWorkouts.first)!)
    }
}
