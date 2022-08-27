//
//  MeetPerformanceList.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct MeetPerformanceList: View {
    
    var performances: [MeetPerformance]
    
    var body: some View {
        List {
            ForEach(performances) { result in
                MeetPerformanceView(performance: result)
            }
        }
    }
}
