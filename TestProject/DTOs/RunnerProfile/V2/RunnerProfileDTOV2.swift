//
//  RunnerProfileDTOV2.swift
//  UAXC
//
//  Created by David  Terkula on 12/27/22.
//

import Foundation

struct RunnerProfileDTOV2: Codable {
    
    var runner: Runner
    var rankedPR: RankedPRDTO?
    var rankedSB: RankedSBDTO?
    var consistencyRank: RankedSplitConsistencyDTO?
    var timeTrial: TimeTrialProgression?
    var distanceRun: RankedRunnerDistanceRunDTO?
    var goals: [GoalsDTO]
    var trainingRuns: [TrainingRunResult]
    var workoutResults: [ARunnersWorkoutResultsResponse]
    var meetResults: [MeetResult]
    var trainingRunSummary: [TrainingSummaryDTO]
    
    
    private enum CodingKeys: String, CodingKey {
        case runner, goals, trainingRuns, meetResults, trainingRunSummary
        case rankedPR = "rankedPRDTO"
        case rankedSB = "rankedSBDTO"
        case consistencyRank = "raceConsistencyDTO"
        case timeTrial = "timeTrialImprovementDTO"
        case distanceRun = "rankedDistanceRunDTO"
        case workoutResults = "workouts"
        
      
    }
    
}
