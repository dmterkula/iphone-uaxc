//
//  CoachAddRunnersTrainingRunView.swift
//  UAXC
//
//  Created by David  Terkula on 12/21/22.
//

import SwiftUI

struct CoachAddRunnersTrainingRunView: View {
    
    var trainingRunEvent: TrainingRunEvent
    @Binding var runners: [Runner]
    @Binding var runnerName: String
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("Add Training Run Data For: ")) {
                    Menu {
                        RunnerPickerView(runners: $runners, runnerLabel: $runnerName)
                    } label: {
                        HStack {
                            Text("Select Runner" )
                            
                            if (!runnerName.isEmpty) {
                                Text(runnerName.components(separatedBy: ":")[0])
                                    .foregroundColor(.black)
                            
                            }
                            
                        }
                        
                    }
                    
                    if (!runnerName.isEmpty) {
                        NavigationLink(destination: TrainingRunLandingPageAthletesView(trainingRunEvent: trainingRunEvent, showEditSheet: false, runner: runners.first { $0.name == runnerName.components(separatedBy: ":")[0]}!).environment(\.colorScheme, .light)) {
                            HStack {
                                Text("Add data")
                            }
                                
                        }
                    }
                }
                
            }
        }
    }
}

//struct CoachAddRunnersTrainingRunView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoachAddRunnersTrainingRunView()
//    }
//}
