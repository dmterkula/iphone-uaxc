//
//  BarComparison.swift
//  UAXC
//
//  Created by David  Terkula on 9/11/22.
//

import Foundation

struct BarComparison: Identifiable {
    
    var id = UUID()
    var barsDataSet1: [Bar]
    var dataSet1LegendLabel: String
    var barsDataSet2: [Bar]
    var dataSet2LegendLabel: String
    var comparisonLabels: [String]

}
