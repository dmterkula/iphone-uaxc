//
//  Meet.swift
//  UAXC
//
//  Created by David  Terkula on 11/12/22.
//

import Foundation

struct Meet: Codable, Identifiable {
    
    var id = UUID()
    
    var name: String
    var date: Date
    var icon: String?
    var uuid: String

    private enum CodingKeys: String, CodingKey {
        case name, date, uuid, icon
    }
    
}
