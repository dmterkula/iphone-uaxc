//
//  PRList.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct PerformanceList: View {
    
    var performances: [Performance]
    
    @Binding
    var filter: String
    
    var body: some View {
        
        var filteredPerformances = performances
        
        if (!filter.isEmpty) {
            filteredPerformances = performances.filter{$0.runner.name.lowercased().contains(filter.lowercased())}
        }
        
        return List {
            ForEach(filteredPerformances) { perf in
                PerformanceView(perf: perf)
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}
