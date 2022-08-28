//
//  PRViewWithImprovement.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct PerformanceViewWithImprovement: View {
    var performance: Performance
    var defaultString = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(performance.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 3) {
                        Text(performance.result[0].time)
                        Text("\(performance.result[0].meetName): \(performance.result[0].meetDate)")
                    }
                    
                    if (performance.improvedUpon == nil || performance.improvedUpon!.meet == nil) {
                        Text("No improvement, first race")
                    } else {
                        Text("Improved Upon")
                        HStack(spacing: 3) {
                        Text(performance.improvedUpon!.meet!.time)
                        Text("\(performance.improvedUpon!.meet!.meetName): \(performance.improvedUpon!.meet!.meetDate)")

                        }
                        
                        HStack(spacing: 3) {
                            Text("Improvement Amount: " + (performance.improvedUpon?.timeDifference ?? defaultString) )
                        }
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
