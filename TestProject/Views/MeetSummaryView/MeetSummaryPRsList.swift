//
//  MeetSummaryPRsList.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetSummaryPRsList: View {
    var prs: [Performance]
    
    var body: some View {
        List {
            ForEach(prs) { pr in
                PRViewWithImprovement(pr: pr)
            }
        }
    }
}

//struct MeetSummaryPRsList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsList()
//    }
//}
