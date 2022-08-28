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
        List {
            ForEach(performances) { pr in
                PerformanceViewWithImprovement(performance: pr)
            }
        }
    }
}

//struct MeetSummaryPRsList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsList()
//    }
//}
