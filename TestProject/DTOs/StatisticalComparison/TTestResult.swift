//
//  TTestResult.swift
//  UAXC
//
//  Created by David  Terkula on 9/10/22.
//

import Foundation

struct TTestResult: Codable, Identifiable {
    
    var id = UUID()
    var label: String
    var pvalue: Double
    
    private enum CodingKeys: String, CodingKey {
        case label, pvalue
    }
    
}
