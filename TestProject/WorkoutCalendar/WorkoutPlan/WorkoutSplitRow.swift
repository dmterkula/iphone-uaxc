//
//  WorkoutSplitRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/28/22.
//

import SwiftUI

struct WorkoutSplitRow: View {
    
    var runnerWorkoutSplit: RunnerWorkoutPlan
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(runnerWorkoutSplit.runner.name)
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.headline)
                    .padding(.leading, 8)
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Target Time: ")
                            Text(runnerWorkoutSplit.targetedPaces.first!.pace)

                        }
                        
                        HStack(spacing: 3) {
                            Text("Target 5k Time: ")
                            Text(runnerWorkoutSplit.baseTime)
                        }
                    }
                    
                    Spacer()
                    
                }.padding(.leading, 8)
            }
        }
        
    }
}

//struct WorkoutSplitRow_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutSplitRow()
//    }
//}
