//
//  MeeSummaryYearToYearProgressionView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetSummaryYearToYearProgressionView: View {
    var progressionData: ProgressionData?
    
    var body: some View {
        VStack {
            
            Text("Results Compared to Last Year")
                .font(.system(size: 36))
                .foregroundColor(.blue)
        
            MeetYearToYearProgressionList(fasterProgressions: progressionData?.fasterProgressions.results ?? [], slowerProgressions: progressionData?.slowerProgressions.results ?? [])
            
        }
    }
}


//struct MeeSummaryYearToYearProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeeSummaryYearToYearProgressionView()
//    }
//}
