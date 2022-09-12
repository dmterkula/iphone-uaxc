//
//  MeetSplitBarComparison.swift
//  UAXC
//
//  Created by David  Terkula on 9/11/22.
//

import Foundation

struct MeetSplitBarComparison: Identifiable {
    
    var id = UUID()
    var meetName: String
    var mile1BarComparison: BarComparison
    var mile2BarComparison: BarComparison
    var mile3BarComparison: BarComparison
    var tTestResults: [TTestResult]
    
}
