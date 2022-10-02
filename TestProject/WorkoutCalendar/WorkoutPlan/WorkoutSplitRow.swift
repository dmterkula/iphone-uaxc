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
                    .padding(.leading, 8)
                    .font(.system(size: 20))
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 3) {
                            Text("Target Time: ")
                                .font(.system(size: 20))
                            Text(runnerWorkoutSplit.targetedPaces.first!.pace)
                                .font(.system(size: 20))

                        }
                        
                        HStack(spacing: 3) {
                            Text("Target 5k Time: ")
                                .font(.system(size: 20))
                            Text(runnerWorkoutSplit.baseTime)
                                .font(.system(size: 20))
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
