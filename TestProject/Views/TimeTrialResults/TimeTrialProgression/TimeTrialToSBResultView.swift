//
//  TimeTrialComparisonView.swift
//  UAXC
//
//  Created by David  Terkula on 9/7/22.
//

import SwiftUI

struct TimeTrialToSBResultView: View {
    var timeTrialProgression: TimeTrialProgression
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(timeTrialProgression.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                
                Text("Adjusted Time Trial: " + timeTrialProgression.adjustedTimeTrial)
                    .foregroundColor(.primary)
                
                Text("Season Best: " + timeTrialProgression.seasonBest)
                    .foregroundColor(.primary)
                
                HStack(spacing: 3) {
                    Label(String(timeTrialProgression.rank), systemImage: "figure.run")
                    Label(timeTrialProgression.improvement, systemImage: "stopwatch")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}




//struct TimeTrialComparisonView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialToSBResultView()
//    }
//}
