//
//  PRView.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct PRView: View {
    var pr: Performance

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(pr.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack(spacing: 3) {
                    Label(pr.result[0].time, systemImage: "figure.run")
                    Label("\(pr.result[0].meetName): \(pr.result[0].meetDate)", systemImage: "figure.run")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}
