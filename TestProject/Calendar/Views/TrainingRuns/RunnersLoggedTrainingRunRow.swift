//
//  RunnersLoggedTrainingRunRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import SwiftUI

struct RunnersLoggedTrainingRunRow: View {
    
    var runnersLoggedTrainingRun: TrainingRunResultDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()
                Text(runnersLoggedTrainingRun.runner.name)
                    .foregroundColor(GlobalFunctions.uaGreen())
                    .fontWeight(.bold)
                Spacer()
            }
            
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
}

//struct RunnersLoggedTrainingRunRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnersLoggedTrainingRunRow()
//    }
//}
