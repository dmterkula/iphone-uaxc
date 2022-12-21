//
//  RunnersLoggedTrainingRunRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import SwiftUI

struct RunnersLoggedTrainingRunRow: View {
    
    var runnersLoggedTrainingRun: TrainingRunResultDTO
    var trainingRunEvent: TrainingRunEvent
    
    @State var showEditSheet = true
    
    var body: some View {
        
        Form {
            
            Section(header:
                        
                HStack {
                    Text(runnersLoggedTrainingRun.runner.name)
                        .foregroundColor(GlobalFunctions.uaGreen())
                        .fontWeight(.bold)
                    
                NavigationLink(destination: TrainingRunLandingPageAthletesView(trainingRunEvent: trainingRunEvent, showEditSheet: showEditSheet, runner: runnersLoggedTrainingRun.runner).environment(\.colorScheme, .light)) {
                    HStack {
                        Text("Edit")
                        Image(systemName: "chevron.right")
                    }
                        
                }
                .simultaneousGesture(TapGesture().onEnded{
                    showEditSheet.toggle()
                })
                    
                    }
              ) {
                
                HStack {
                    Text("Recorded Distance: ")
                    Text(String(runnersLoggedTrainingRun.distance))
                }
                
                HStack {
                    Text("Recorded Time: ")
                    Text(runnersLoggedTrainingRun.time)
                }
                
                HStack {
                    Text("Avg. Pace: ")
                    Text(runnersLoggedTrainingRun.avgPace)
                }
            }
 
        }
        .frame(height: 190)

    }
}

//struct RunnersLoggedTrainingRunRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnersLoggedTrainingRunRow()
//    }
//}
