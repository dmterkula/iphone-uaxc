//
//  WorkoutPlanSplitsView.swift
//  UAXC
//
//  Created by David  Terkula on 9/28/22.
//

import SwiftUI



struct WorkoutPlanSplitsView: View {
    
    var runnerWorkoutPlans: [RunnerWorkoutPlan]
    
    var body: some View {
        VStack {
            Text("Runner Splits")
                .foregroundColor(.white)
                .font(.title3)
            
            ForEach(runnerWorkoutPlans) { split in
                WorkoutSplitRow(runnerWorkoutSplit: split)
                CustomDivider(color: .white, height: 2)
            }
            
        }
    }
}

//struct WorkoutPlanSplitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutPlanSplitsView()
//    }
//}
