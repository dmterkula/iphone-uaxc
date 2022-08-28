//
//  PRView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct PerformanceView: View {
    var perf: Performance

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(perf.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack(spacing: 3) {
                    Label(perf.result[0].time, systemImage: "figure.run")
                    Label("\(perf.result[0].meetName): \(perf.result[0].meetDate)", systemImage: "figure.run")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}
