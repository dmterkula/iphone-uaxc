//
//  MeetSplitView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct MeetSplitView: View {
    
    var meetSplit: MeetSplit
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(meetSplit.result.meetName)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                VStack {
                    HStack(spacing: 3) {
                        Text("Time:")
                        Spacer()
                        Text(meetSplit.result.time)
                    }
                    
                    
                    HStack(spacing: 3) {
                        Text("Mile 1:")
                        Spacer()
                        Text(meetSplit.splits.mileOne)
                    }
                    
                    HStack(spacing: 3) {
                        Text("Mile 2:")
                        Spacer()
                        Text(meetSplit.splits.mileTwo)
                    }
                    
                    HStack(spacing: 3) {
                        Text("Mile 3:")
                        Spacer()
                        Text(meetSplit.splits.mileThree)
                    }
                    
                    HStack(spacing: 3) {
                        Text("Avg:")
                        Spacer()
                        Text(meetSplit.splits.average)
                    }
    
                }
            }
        }
    }
}
