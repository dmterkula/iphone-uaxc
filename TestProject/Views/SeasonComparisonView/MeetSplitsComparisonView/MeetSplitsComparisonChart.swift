//
//  MeetSplitsComparisonChart.swift
//  UAXC
//
//  Created by David  Terkula on 9/12/22.
//

import SwiftUI

struct MeetSplitsComparisonChart: View {
    @Binding
    var meetSplitBarComparison: MeetSplitBarComparison
    var geometry: GeometryProxy

    func createPValueInterpretation(tTestResult: TTestResult) -> String {
        
        let percent = (tTestResult.pvalue * 100).rounded(toPlaces: 2)
        return "There is a " + String(percent) + " percent chance that the differnce in Avg. splits times compared to PR pace is due to chance/expected variation"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(meetSplitBarComparison.meetName + " Splits Comparisons").font(.title2)
            
            let mile1ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[0])
            let mile2ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[1])
            let mile3ComparisonDescriptor = createPValueInterpretation(tTestResult: meetSplitBarComparison.tTestResults[2])
            
            SideBySideBarChart(barComparison: meetSplitBarComparison.mile1BarComparison, title: "Mile 1 Pace as a Percent of PR Pace", descriptor: mile1ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.33 * Double(meetSplitBarComparison.mile1BarComparison.barsDataSet1.count))))
            
            SideBySideBarChart(barComparison: meetSplitBarComparison.mile2BarComparison, title: "Mile 2 Pace as a percent of PR Pace", descriptor: mile2ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.33 * Double(meetSplitBarComparison.mile2BarComparison.barsDataSet1.count))))
            
            SideBySideBarChart(barComparison: meetSplitBarComparison.mile3BarComparison, title: "Mile 3 Pace as a Percent of PR Pace", descriptor: mile3ComparisonDescriptor, height: geometry.size.height / 3, width: (geometry.size.width / ( 1.33 * Double(meetSplitBarComparison.mile3BarComparison.barsDataSet1.count))))
        }
    }
}

//struct MeetSplitsComparisonChart_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetSplitsComparisonChart()
//    }
//}
