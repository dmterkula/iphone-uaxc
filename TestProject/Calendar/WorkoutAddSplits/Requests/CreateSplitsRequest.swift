//
//  CreateSplitsRequest.swift
//  UAXC
//
//  Created by David  Terkula on 10/31/22.
//

import Foundation

struct CreateSplitsRequest: Codable {
    var runnerId: Int
    var componentUUID: String
    var splits: [Split]
}


struct Split: Codable {
    var uuid: String
    var number: Int
    var value: String
}
