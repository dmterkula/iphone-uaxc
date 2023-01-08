//
//  CreateAppUserRequest.swift
//  UAXC
//
//  Created by David  Terkula on 1/6/23.
//

import Foundation

struct CreateAppUserRequest: Codable {
    
    var username: String
    var password: String
    var runnerId: Int
    var role: String
    
}
