//
//  RunnerUnmetGoalRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/22/22.
//

import SwiftUI

struct RunnerUnmetGoalRow: View {
    var runnerToUnmetGoal: RunnerToUnmetGoal
    
    var body: some View {
        VStack {
            Text(runnerToUnmetGoal.runner.name)
                .font(.headline)
                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Goal: " + runnerToUnmetGoal.time)
                    Spacer()
                }.padding(.leading, 5)
                
                HStack {
                    Text("Off by: " + runnerToUnmetGoal.difference)
                    Spacer()
                }.padding(.leading, 5)
                
                HStack {
                    Text("Current SB: " + runnerToUnmetGoal.closestPerformance.time)
                    Spacer()
                }.padding(.leading, 5)
                
            }
            
        }
    }
}

//struct RunnerUnmetGoalRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerUnmetGoalRow()
//    }
//}
