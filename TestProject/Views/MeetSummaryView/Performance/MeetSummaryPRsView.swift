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
            
            Text("Count: " + String(prsCount.count))
                .foregroundColor(.white)
            
            ForEach(prsCount.PRs) { i in
                PerformanceViewWithImprovement(performance: i)
                CustomDivider(color: .white, height: 2)
            }
            
        }

}

//struct MeetSummaryPRsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummaryPRsView()
//    }
}
