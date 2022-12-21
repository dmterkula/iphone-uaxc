//
//  EditingWorkoutFormViewModel.swift
//  UAXC
//
//  Created by David  Terkula on 12/15/22.
//

import Foundation

class EditingRunnerWorkoutFormViewModel: ObservableObject {
    
    @Published
    var totalDistance: Double = 0.0
    
    @Published var miles: Int = 0
    @Published var fractionOfMiles: Int = 0
    
    @Published
    var componentToSplits: [WorkoutComponent: [DoubleSplitViewModel]] = [:]
    
    init() {}
    
    init(_ nonEditViewModel: RunnerWorkoutFormViewModel) {
        self.totalDistance = nonEditViewModel.totalDistance
        self.componentToSplits = nonEditViewModel.componentToSplits
    }
    
}
