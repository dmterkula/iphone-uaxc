//
//  BackEndInfoDTO.swift
//  UAXC
//
//  Created by David  Terkula on 11/12/22.
//

import Foundation

struct BackEndInfoDTO: Codable {
    var app: AppInfo
    
}

struct AppInfo: Codable {
    var version: String
}
