//
//  TrainingRun.swift
//  UAXC
//
//  Created by David  Terkula on 11/24/22.
//

import Foundation

struct TrainingRun: Codable, Identifiable {
    
    var id = UUID()
    
    var name: String
    var date: Date
    var time: String?
    var distance: Double?
    var icon: String
    var uuid: String
    
    private enum CodingKeys: String, CodingKey {
        case name, date, time, distance, icon, uuid
    }
    
    
    static var icons: [String] = [
        "📌",
        "👟"
        
    ]
    
    static var iconsToText = [
        "📌": "default",
        "👟": "Training Run",
        ]
    
    static func getTextFromIcon(icon: String) -> String {
        return TrainingRun.iconsToText[icon] == nil ? "Training Run" : TrainingRun.iconsToText[icon]!
    }

    
}
