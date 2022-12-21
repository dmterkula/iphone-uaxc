//
//  SplitsResponse.swift
//  UAXC
//
//  Created by David  Terkula on 10/31/22.
//

import Foundation

struct SplitsResponse: Codable {
    var componentUUID: String
    var runnerId: Int
    var splits: [SplitElement]
    
}

struct SplitElement: Codable, Identifiable {
    
    var id = UUID()
    
    var uuid: String
    var number: Int
    var time: String
    
    private enum CodingKeys: String, CodingKey {
        case uuid, number, time
    }
    
}

