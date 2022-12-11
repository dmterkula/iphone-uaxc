//
//  CreateTrainingRunResponse.swift
//  UAXC
//
//  Created by David  Terkula on 11/25/22.
//

import Foundation

struct TrainingRunResponse: Codable {
    
    var trainingRuns: [TrainingRun]
    
    private enum CodingKeys: String, CodingKey {
        case trainingRuns
    }
}

struct TrainingRunDTO: Codable, Identifiable {
    
    var id = UUID()

    var date: Date
    var distance: Double?
    var time: String?
    var icon: String
    var uuid: String
    var name: String

    private enum CodingKeys: String, CodingKey {
        case date, distance, time, icon, uuid, name
    }
    
}
