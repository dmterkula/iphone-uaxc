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
            
            Text("Count: " + String(sbsCount.count))
                .foregroundColor(.white)
            
            ForEach(sbsCount.seasonBests) { i in
                PerformanceViewWithImprovement(performance: i)
                CustomDivider(color: .white, height: 2)
            }
        }
    }
}

//struct MeetSummarySBView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSummarySBView()
//    }
//}
