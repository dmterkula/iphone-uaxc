//
//  MeetToMeetProgressionList.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI

struct MeetToMeetProgressionList: View {
    
    var averageDifference: String
    var medianDifference: String
    var fasterProgressions: MeetToMeetProgressions
    var slowerProgression: MeetToMeetProgressions
    
    var body: some View {
        
        if (averageDifference == "0:00.0" && medianDifference == "0:00.0") {
            Text("No previous meet found within given sesaon")
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
                
                if (!(fasterProgressions.improvementRateDTOs + slowerProgression.improvementRateDTOs).isEmpty) {
                    List {
                        ForEach(fasterProgressions.improvementRateDTOs + slowerProgression.improvementRateDTOs) { improvementRateDTO in
                            MeetToMeetProgressionView(improvementRateDTO: improvementRateDTO)
                        }
                    }
                }
                
            }
        }
    }
}



//struct MeetToMeetProgressionList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetToMeetProgressionList()
//    }
//}
