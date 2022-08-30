//
//  MeetSplitSummaryView.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI

struct MeetSplitSummaryView: View {
    var meetSplitStats: [MeetSplitSummaryStat]?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("Team Meet Splits Summary")
                .font(.system(size: 36))
                .foregroundColor(.blue)
            
            Spacer().frame(minHeight: 25, maxHeight: 50)
            
            HStack(spacing: 3) {
                Text("1st Mile to 2nd Mile: ")
                Text(String(meetSplitStats?[0].value ?? Float(0.0)) )
            }
            
            HStack(spacing: 3) {
                Text("2nd to 3rd Mile: ")
                Text(String(meetSplitStats?[1].value ?? Float(0.0)) )
            }
            
            HStack(spacing: 3) {
                Text("Spread: ")
                Text(String(meetSplitStats?[3].value ?? Float(0.0)))
            }
        }
    }
}




//struct MeetSplitSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSplitSummaryView()
//    }
//}
