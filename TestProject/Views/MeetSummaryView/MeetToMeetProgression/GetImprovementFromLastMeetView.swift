//
//  GetImprovementFromLastMeetView.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI

struct GetImprovementFromLastMeetView: View {
    
    var comparisonLastMeet: SummaryImprovementLastMeet?
    
    var body: some View {
        VStack {
            
            Text("Results Compared to Last Meet")
                .font(.system(size: 36))
                .foregroundColor(.blue)
        
            Spacer().frame(minHeight: 15, maxHeight: 30)
            
            MeetToMeetProgressionList(averageDifference: comparisonLastMeet?.averageDifference ?? "n/a", medianDifference: comparisonLastMeet?.medianDifference ?? "n/a", fasterProgressions: comparisonLastMeet?.faster ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: []), slowerProgression: comparisonLastMeet?.slower ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: []))
            
        }
    }
}



//struct GetImprovementFromLastMeetView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetImprovementFromLastMeetView()
//    }
//}
