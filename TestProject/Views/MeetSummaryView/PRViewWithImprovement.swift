//
//  PRViewWithImprovement.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct PRViewWithImprovement: View {
    var pr: Performance
    var defaultString = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(pr.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                VStack {
                    Text("PR")
                    HStack(spacing: 3) {
                        Label(pr.result[0].time, systemImage: "figure.run")
                        Label("\(pr.result[0].meetName): \(pr.result[0].meetDate)", systemImage: "figure.run")
                    }
                    Text("Improved Upon")
                    HStack(spacing: 3) {
                        Label(pr.improvedUpon.meet?.time ?? defaultString, systemImage: "figure.run")
                        Label("\(pr.improvedUpon.meet?.meetName ?? defaultString): \(pr.improvedUpon.meet?.meetDate ?? defaultString)", systemImage: "figure.run")
                    }
                    
                    HStack(spacing: 3) {
                        Text("Improvement Amount: " + pr.improvedUpon.timeDifference)
                    }
                }
                
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

//struct PRViewWithImprovement_Previews: PreviewProvider {
//    static var previews: some View {
//        PRViewWithImprovement()
//    }
//}
