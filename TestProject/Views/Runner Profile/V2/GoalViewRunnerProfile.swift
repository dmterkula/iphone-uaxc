//
//  GoalViewRunnerProfile.swift
//  UAXC
//
//  Created by David  Terkula on 12/27/22.
//

import SwiftUI

struct GoalViewRunnerProfile: View {
    
    var goals: [GoalsDTO]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(goals) { goal in
                HStack {
                    Text("Goal Type")
                        .bold()
                    Text(goal.type)
                }
                
                HStack {
                    Text("Goal")
                        .bold()
                    Text(goal.value)
                }
                
                HStack {
                    Text("Has been met?")
                        .bold()
                    if (goal.met) {
                        Text("Yes!")
                    } else {
                        Text("Not yet")
                    }
                }
                
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
                
            }
            .listRowSeparator(.hidden)
            
        }
    }
}

//struct GoalViewRunnerProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalViewRunnerProfile()
//    }
//}
