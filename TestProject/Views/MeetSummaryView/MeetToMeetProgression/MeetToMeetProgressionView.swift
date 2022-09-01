//
//  MeetToMeetProgressionView.swift
//  TestProject
//
//  Created by David  Terkula on 8/28/22.
//

import SwiftUI

struct MeetToMeetProgressionView: View {
    
    var improvementRateDTO: ImprovementRateDTO
    
    var body: some View {
        ScrollView {
            HStack(alignment: .center, spacing: 5) {
                Text(improvementRateDTO.runner.name)
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.headline)
                Text(improvementRateDTO.delta)
                    .foregroundColor(.white)
                
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

//struct MeetToMeetProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetToMeetProgressionView()
//    }
//}
