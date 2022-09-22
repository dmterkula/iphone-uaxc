//
//  RunnerToMetGoalsRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/19/22.
//

import SwiftUI

struct RunnerToMetGoalsRow: View {
    
    var runnerToMetGoal: RunnerToMetGoal
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Spacer()
                    Text(runnerToMetGoal.runner.name)
                        .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                        .font(.headline)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    
                    HStack(spacing: 3) {
                        Spacer()
                        Text("Result: " )
                        Text(runnerToMetGoal.metGoals.first?.at.time ?? "No time at meet")
                        Spacer()
                    }
                   
                    ForEach(runnerToMetGoal.metGoals) { goal in
                        HStack(spacing: 3) {
                            Spacer()
                            Text("Goal: ")
                            Text(goal.time)
                            Spacer()
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.subheadline)

            }
        }
       
    }
        
}

//struct RunnerToMetGoalsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerToMetGoalsRow()
//    }
//}
