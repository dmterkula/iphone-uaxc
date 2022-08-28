//
//  MeetSummarySBView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetSummarySBsView: View {
    
    var sbsCount: SBsCount
    
    var body: some View {
        VStack {
            
            Text("Season Bests")
                .font(.system(size: 36))
                .foregroundColor(.blue)
            
            Text("SB Count: " + String(sbsCount.count))
            
            MeetSummaryPerformanceList(performances: sbsCount.seasonBests)
        }
    }
}

//struct MeetSummarySBView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummarySBView()
//    }
//}
