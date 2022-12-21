//
//  RunnerTrainingRunResponse.swift
//  UAXC
//
//  Created by David  Terkula on 12/1/22.
//

import Foundation

struct RunnerTrainingRunResponse: Codable {
    
    var runnerTrainingRuns: [TrainingRunResultDTO]
    
}

struct TrainingRunResultDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var runner: Runner
    var uuid: String
    var trainingRunUuid: String
    var time: String
    var distance: Double
    var avgPace: String
    
    private enum CodingKeys: String, CodingKey {
        case runner, uuid, trainingRunUuid, time, distance, avgPace
    }
    
}
