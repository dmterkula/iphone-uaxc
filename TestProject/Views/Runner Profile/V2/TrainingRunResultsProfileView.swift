//
//  TrainingRunResultsProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 12/27/22.
//

import SwiftUI

struct TrainingRunResultsProfileView: View {
    
    var results: [TrainingRunResult]
    
    var body: some View {
        ForEach(results) { result in
            TrainingRunResultRow(result: result)
                .listRowSeparator(.hidden)
            CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
        }
        
    }
}

struct TrainingRunResultRow: View {
    
    @EnvironmentObject var authentication: Authentication
    var result: TrainingRunResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(result.trainingRun.date.formatted(date: .complete, time: .omitted))
                    .bold()
                
                if (authentication.user?.role == "runner") {
                    NavigationLink(destination: TrainingRunLandingPageAthletesView(trainingRunEvent: TrainingRunEvent(trainingRun: result.trainingRun), runner: authentication.runner!).environment(\.colorScheme, .light)) {
                    }
                } else if (authentication.user?.role == "coach") {
                    NavigationLink(destination: TrainingRunLandingPageCoachesView(trainingRunEvent: TrainingRunEvent(trainingRun: result.trainingRun)).environment(\.colorScheme, .light)) {
                    
                    }
                }
                
            }
            
            HStack {
                Text("Logged Distance:")
                    .bold()
                Text(String(result.results.first!.distance))
            
            }
            
            HStack {
                Text("Logged Time:")
                    .bold()
                Text(result.results.first!.time)
            }
            
            HStack {
                Text("Avg Pace:")
                    .bold()
                Text(result.results.first!.avgPace)
            }
            
        }
    }
    
}

//struct TrainingRunResultsProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingRunResultsProfileView()
//    }
//}
