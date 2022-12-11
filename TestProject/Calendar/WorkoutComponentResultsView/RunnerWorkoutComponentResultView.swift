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
        
        VStack {
            Text(result.runner.name)
            ForEach(result.splits) { split in
                SplitRow(number: split.number, time: split.time)
            }
            Text("Avg: " + result.average)
        }
    }
}

//struct RunnerWorkoutComponentResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerWorkoutComponentResultView()
//    }
//}
