//
//  MeetPerformanceView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct MeetPerformanceView: View {
    var performance: MeetPerformance

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(performance.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack(spacing: 3) {
                    Label(performance.result[0].time, systemImage: "figure.run")
                    Label("place: \(performance.result[0].place)", systemImage: "figure.run")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}
