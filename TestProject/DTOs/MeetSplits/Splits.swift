//
//  Splits.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import Foundation

struct Splits: Codable, Identifiable {
    
    var id = UUID().uuidString
    var mileOne: String
    var mileTwo: String
    var mileThree: String
    var average: String
    
    private enum CodingKeys: String, CodingKey {
        case mileOne = "mileOne"
        case mileTwo = "mileTwo"
        case mileThree = "mileThree"
        case average = "average"
    }
}
