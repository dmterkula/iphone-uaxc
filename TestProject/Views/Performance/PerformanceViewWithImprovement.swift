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
                    .foregroundColor(Color(red: 249/255, green: 229/255, blue: 0/255))
                    .font(.headline)
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 3) {
                        Text(performance.result[0].time)
                            .foregroundColor(.white)
                        Text("\(performance.result[0].meetName): \(performance.result[0].meetDate)")
                            .foregroundColor(.white)
                    }
                    
                    if (performance.improvedUpon == nil || performance.improvedUpon!.meet == nil) {
                        Text("No improvement, first race")
                            .foregroundColor(.white)
                    } else {
                        Text("Improved Upon")
                            .foregroundColor(.white)
                        HStack(spacing: 3) {
                        Text(performance.improvedUpon!.meet!.time)
                                .foregroundColor(.white)
                        Text("\(performance.improvedUpon!.meet!.meetName): \(performance.improvedUpon!.meet!.meetDate)")
                                .foregroundColor(.white)

                        }
                        
                        HStack(spacing: 3) {
                            Text("Improvement Amount: " + (performance.improvedUpon?.timeDifference ?? defaultString) )
                                .foregroundColor(.white)
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
