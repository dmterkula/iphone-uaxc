//
//  RunnerWorkoutFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import Foundation

class RunnerWorkoutFormViewModel {
    
    var totalDistance: Double = 0.0
    var componentToSplits: [WorkoutComponent: [DoubleSplitViewModel]] = [:]
    
    init() {}
    
    init(distance: Double, compToSplits: [WorkoutComponent: [DoubleSplitViewModel]]) {
        self.totalDistance = distance
        self.componentToSplits = compToSplits
    }
    
    
    init(_editabledViewModel: EditingRunnerWorkoutFormViewModel) {
        self.totalDistance = _editabledViewModel.totalDistance
        self.componentToSplits = _editabledViewModel.componentToSplits
    }
    
}
