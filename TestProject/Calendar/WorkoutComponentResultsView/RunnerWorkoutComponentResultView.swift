//
//  RunnerWorkoutComponentResultView.swift
//  UAXC
//
//  Created by David  Terkula on 11/6/22.
//

import SwiftUI

struct RunnerWorkoutComponentResultView: View {
    
    var component: WorkoutComponent
    var result: ComponentResult
    
    var body: some View {
        
        Form() {
            Section(header:
                Text(result.runner.name).foregroundColor(GlobalFunctions.uaGreen())
                .font(.system(size: 15))
            ) {
                VStack {
                    ForEach(result.splits) { split in
                        SplitRow(number: split.number, time: split.time)
                    }
                    Text("Avg: " + result.average)
                }
            }
        }
        .textCase(nil)
        .frame(height: 150)
        
    }
}

//struct RunnerWorkoutComponentResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerWorkoutComponentResultView()
//    }
//}
