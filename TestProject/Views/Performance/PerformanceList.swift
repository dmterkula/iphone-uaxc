//
//  PRList.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct PerformanceList: View {
    
    var performances: [Performance]
    
    var body: some View {
        List {
            ForEach(performances) { perf in
                PerformanceView(perf: perf)
            }
        }
    }
}
