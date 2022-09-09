//
//  TimeTrialComparisonListView.swift
//  UAXC
//
//  Created by David  Terkula on 9/9/22.
//

import SwiftUI

struct TimeTrialComparisonListView: View {
    
    @Binding var comparisonDTOs: [RunnerTimeTrialComparisonToPreviousYearDTO]
    var minHeight: Double
    
    var body: some View {
        List {
            ForEach(comparisonDTOs) { comparison in
                VStack(alignment: .leading, spacing: 3) {
                    Text(comparison.runner.name)
                        .foregroundColor(.primary)
                        .font(.headline)
                    HStack {
                        Label("\(comparison.results[0].season)", systemImage: "calendar")
                        Label("\(comparison.results[0].time)", systemImage: "stopwatch")
                        Label("\(comparison.results[0].place)", systemImage: "person")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    
                    HStack {
                        Label("\(comparison.results[1].season)", systemImage: "calendar")
                        Label("\(comparison.results[1].time)", systemImage: "stopwatch")
                        Label("\(comparison.results[1].place)", systemImage: "person")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    
                    HStack(spacing: 3) {
                        Text("Difference: " + comparison.timeDifference)
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
            }
        }
        .frame(minHeight: minHeight)
        .ignoresSafeArea()
    }
}

//struct TimeTrialComparisonListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialComparisonListView()
//    }
//}
