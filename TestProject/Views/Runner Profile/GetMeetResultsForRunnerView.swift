//
//  GetMeetResultsForRunnerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import SwiftUI

struct GetMeetResultsForRunnerView: View {
    var runnerMeetPerformanceDTO: RunnerMeetPerformanceDTO
    var body: some View {
        
        ForEach(runnerMeetPerformanceDTO.performance) { result in 
            HStack(spacing: 10) {
                MeetResultView(result: result)
            }.padding(.vertical, 10.0)
        }
    }
}



//struct GetMeetResultsForRunnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetMeetResultsForRunnerView()
//    }
//}
