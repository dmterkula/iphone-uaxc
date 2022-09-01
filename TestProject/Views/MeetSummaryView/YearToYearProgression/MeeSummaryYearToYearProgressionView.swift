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
            let combinedList = progressionData?.fasterProgressions.results ?? [] + (progressionData?.slowerProgressions.results ?? [])
            
            if (!combinedList.isEmpty) {
               
                Text("Faster than same meet last year: " + String((progressionData?.fasterProgressions.results.count)!))
                    .foregroundColor(.white)
                
                Text("Slower than same meet last year: " + String((progressionData?.slowerProgressions.results.count)!))
                    .foregroundColor(.white)
                
                CustomDivider(color: .white, height: 2)
                
            }
            
            ForEach(combinedList) { i in
                ProgressionView(progression: i)
                CustomDivider(color: .white, height: 2)
            }
        }
    }
}


//struct MeeSummaryYearToYearProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeeSummaryYearToYearProgressionView()
//    }
//}
