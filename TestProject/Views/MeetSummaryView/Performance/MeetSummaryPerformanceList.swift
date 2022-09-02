//
//  MeetSummaryPRsList.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetSummaryPerformanceList: View {
    var performances: [Performance]
    
    var body: some View {
        if (!performances.isEmpty) {
            List {
                ForEach(performances) { pr in
                    PerformanceViewWithImprovement(performance: pr)
                }
            }.listStyle(SidebarListStyle())
        }
    }
}

//struct MeetSummaryPRsList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsList()
//    }
//}
