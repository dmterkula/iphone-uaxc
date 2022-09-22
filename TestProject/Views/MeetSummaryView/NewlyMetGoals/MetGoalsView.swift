//
//  NewlyMetGoalsView.swift
//  UAXC
//
//  Created by David  Terkula on 9/19/22.
//

import SwiftUI

struct MetGoalsView: View {
    
    var metGoals: [RunnerToMetGoal]
    
    var body: some View {
                
        ForEach(metGoals) { metGoal in
            RunnerToMetGoalsRow(runnerToMetGoal: metGoal)
            CustomDivider(color: .white, height: 2)
        }
    }
}



//struct NewlyMetGoalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewlyMetGoalsView()
//    }
//}
