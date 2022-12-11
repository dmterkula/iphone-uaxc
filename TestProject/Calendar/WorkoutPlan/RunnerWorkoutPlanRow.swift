//
//  RunnerWorkoutPlanRow.swift
//  UAXC
//
//  Created by David  Terkula on 10/13/22.
//

import SwiftUI

struct RunnerWorkoutPlanRow: View {
    
    var runnerWorkoutPlan: RunnerWorkoutPlan
    
    var body: some View {
        
//        HStack {
//            
//            Spacer()
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Text(runnerWorkoutPlan.runner.name)
                        .foregroundColor(Color(red: 0/255, green: 127/255, blue: 2/255))
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 4)
                    
                    Spacer()
                }
                
                
                ForEach(runnerWorkoutPlan.componentPlans) { compPlan in
                    RunnerComponentPlanView(compPlan: compPlan)
                }
            }
            
//            Spacer()
//
//        }
        

    }
}

//struct RunnerWorkoutPlanRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerWorkoutPlanRow()
//    }
//}
