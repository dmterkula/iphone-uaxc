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
        
        let averageDifference = comparisonLastMeet?.averageDifference ?? "n/a"
        let medianDifference = comparisonLastMeet?.medianDifference ?? "n/a"
        let fasterProgressions = comparisonLastMeet?.faster ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: [])
        let slowerProgression = comparisonLastMeet?.slower ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: [])
        
        if (averageDifference == "0:00.0" && medianDifference == "0:00.0") {
            Text("No previous meet found within given sesaon").foregroundColor(.white)
        } else {
            VStack(alignment: .center, spacing: 5) {
                HStack(spacing: 3) {
                    Text("Average Difference: ")
                        .foregroundColor(.white)
                    Text(averageDifference)
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 3) {
                    Text("Median Difference: ")
                        .foregroundColor(.white)
                    Text(medianDifference)
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 3) {
                    Text("Faster Count: ")
                        .foregroundColor(.white)
                    Text(String(fasterProgressions.count))
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 3) {
                    Text("Slower Count: ")
                        .foregroundColor(.white)
                    Text(String(slowerProgression.count))
                        .foregroundColor(.white)
                }
                
                CustomDivider(color: .white, height: 2)
                
                ForEach(fasterProgressions.improvementRateDTOs + slowerProgression.improvementRateDTOs) { improvementRateDTO in
                    MeetToMeetProgressionView(improvementRateDTO: improvementRateDTO)
                    CustomDivider(color: .white, height: 2)
                }
            }
        }
           
                
                                
//                MeetToMeetProgressionList(averageDifference: comparisonLastMeet?.averageDifference ?? "n/a", medianDifference: comparisonLastMeet?.medianDifference ?? "n/a", fasterProgressions: comparisonLastMeet?.faster ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: []), slowerProgression: comparisonLastMeet?.slower ?? MeetToMeetProgressions(count: 0, improvementRateDTOs: []))
       
    }
}



//struct GetImprovementFromLastMeetView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetImprovementFromLastMeetView()
//    }
//}
