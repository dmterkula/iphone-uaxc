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
            VStack(alignment: .leading, spacing: 3) {
                Text(improvementRateDTO.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Label(improvementRateDTO.delta, systemImage: "figure.run" )
                
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
