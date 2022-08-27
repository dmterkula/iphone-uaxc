//
//  MeetSummaryPRsView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetSummaryPRsView: View {
    
    var prsCount: PRsCount
    
    var body: some View {
        VStack {
            
            Text("PR Count: " + String(prsCount.count))
            
            MeetSummaryPRsList(prs: prsCount.PRs)
            
    }
}

//struct MeetSummaryPRsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsView()
//    }
}
