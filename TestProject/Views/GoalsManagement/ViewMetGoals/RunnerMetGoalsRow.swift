//
//  RunnerMetGoalsRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/21/22.
//

import SwiftUI

struct RunnerMetGoalsRow: View {
    var runner: String
    var metGoals: [MetGoal]
    
    var body: some View {
        VStack {
            Text(runner)
                .font(.headline)
                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
            
            ForEach(metGoals) { metGoal in
                VStack(alignment: .leading) {
                    HStack {
                        Text("Goal: " + metGoal.time)
                        Spacer()
                    }.padding(.leading, 5)
                    
                    HStack {
                        Text("Met at: " + metGoal.at.meetName + ": " + metGoal.at.meetDate)
                        Spacer()
                    }.padding(.leading, 5)
                    
                    HStack {
                        Text("With time: " + metGoal.at.time)
                        Spacer()
                    }.padding(.leading, 5)
                   
                    
                    if (metGoal.id != metGoals[metGoals.count - 1].id) {
                        CustomDivider(color: .gray, height: 1)
                    }
                    
                }
            }
            
        }
    }
}

//struct RunnerMetGoalsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerMetGoalsRow()
//    }
//}
