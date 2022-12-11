//
//  WorkoutComponentPlanView.swift
//  UAXC
//
//  Created by David  Terkula on 10/16/22.
//

import SwiftUI

struct WorkoutComponentPlanRowView: View {
    
    var workoutComponentPlan: WorkoutComponentToRunnerPlans
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                VStack {
                    Text(workoutComponentPlan.component.description)
                        .font(.title2)
                    Text("Pace: " + workoutComponentPlan.component.pace)
                        .font(.title2)
                }
                
                Spacer()
                
            }.padding(.bottom, 10)
            
            
            ForEach(workoutComponentPlan.runnerWorkoutPlans) { plan in
                RunnerWorkoutPlanRow(runnerWorkoutPlan: plan)
            }
            
        }
       
    }
}

//struct WorkoutComponentPlanRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutComponentPlanRowView()
//    }
//}
