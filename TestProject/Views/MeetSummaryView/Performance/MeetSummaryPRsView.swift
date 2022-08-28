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
            
            Text("PRs")
                .font(.system(size: 36))
                .foregroundColor(.blue)
            
            Text("PR Count: " + String(prsCount.count))
            
            MeetSummaryPerformanceList(performances: prsCount.PRs)
            
    }
}

//struct MeetSummaryPRsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsView()
//    }
}
