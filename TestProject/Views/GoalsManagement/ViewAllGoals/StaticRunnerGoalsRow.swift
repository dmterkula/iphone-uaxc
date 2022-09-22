//
//  StaticRunnerGoalsRow.swift
//  UAXC
//
//  Created by David  Terkula on 9/21/22.
//

import SwiftUI

struct StaticRunnerGoalsRow: View {
    
    var runner: String
    var goals: [GoalsDTO]
    
    var body: some View {
        VStack {
            Text(runner)
                .font(.headline)
                .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
            
            ForEach(goals) { goalDTO in
                VStack(alignment: .leading) {
                    let metString: String = goalDTO.met ? "Yes" : "No"
                    HStack {
                        Text("Goal: " + goalDTO.value)
                        Spacer()
                    }.padding(.leading, 5)
                    HStack {
                        Text("Goal Type: " + goalDTO.type)
                        Spacer()
                    }.padding(.leading, 5)
                    
                    HStack {
                        Text("Has Met Goal: " + metString)
                        Spacer()
                    }.padding(.leading, 5)
                    
                    if (goalDTO.id != goals[goals.count - 1].id) {
                        CustomDivider(color: .gray, height: 1)
                    }
                    
                }
            }
            
        }
    }
}

//struct StaticRunnerGoalsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        StaticRunnerGoalsRow()
//    }
//}
