//
//  TrainingWeeklySummaryDTOs.swift
//  UAXC
//
//  Created by David  Terkula on 12/23/22.
//

import Foundation

struct TrainingSummaryDTO: Codable, Identifiable {
    
    var id = UUID()
    
    var startDate: Date
    var endDate: Date
    var totalDistance: Double
    var runCount: Int
    var trainingAvgPace: String
    
    private enum CodingKeys: String, CodingKey {
        case startDate, endDate, totalDistance, trainingAvgPace
        case runCount = "totalCount"
    }
    
}
