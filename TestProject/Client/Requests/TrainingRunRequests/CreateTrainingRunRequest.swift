//
//  CreateTrainingRunRequest.swift
//  UAXC
//
//  Created by David  Terkula on 11/25/22.
//

import Foundation

struct CreateTrainingRunRequest: Codable {
    
    var uuid: String
    var date: String
    var time: String?
    var distance: Double?
    var icon: String
    var name: String
    
}
