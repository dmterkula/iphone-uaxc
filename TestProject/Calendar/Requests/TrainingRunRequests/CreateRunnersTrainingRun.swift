//
//  CreateRunnersTrainingRun.swift
//  UAXC
//
//  Created by David  Terkula on 12/4/22.
//

import Foundation

struct CreateRunnersTrainingRunRequest: Codable {
    var uuid: String
    var trainingRunUUID: String
    var runnerId: Int
    var time: String
    var distance: Double
    var avgPace: String
}
