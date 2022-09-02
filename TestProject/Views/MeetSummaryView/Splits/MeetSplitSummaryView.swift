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
                        
            HStack(spacing: 3) {
                Text("1st Mile to 2nd Mile: ")
                    .foregroundColor(.white)
                Text(String(meetSplitStats?[0].value ?? Float(0.0)) )
                    .foregroundColor(.white)
            }.padding(.top, 10)
            
            HStack(spacing: 3) {
                Text("2nd to 3rd Mile: ")
                    .foregroundColor(.white)
                Text(String(meetSplitStats?[1].value ?? Float(0.0)) )
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 3) {
                Text("Spread: ")
                    .foregroundColor(.white)
                Text(String(meetSplitStats?[3].value ?? Float(0.0)))
                    .foregroundColor(.white)
            }.padding(.bottom, 10)
        }
    }
}




//struct MeetSplitSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSplitSummaryView()
//    }
//}
