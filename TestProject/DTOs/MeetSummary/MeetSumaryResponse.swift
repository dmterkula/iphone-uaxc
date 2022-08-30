//
//  MeetSumaryResponse.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import Foundation

struct MeetSummaryResponse: Codable {
    var prs: PRsCount
    var seasonBests: SBsCount
    var comparisonFromLastYear: ProgressionData
    var meetSplitsSummaryResponse: MeetSplitStatisticResponse
    var comparisonLastMeet: SummaryImprovementLastMeet
    
    private enum CodingKeys: String, CodingKey {
        case prs, seasonBests, comparisonFromLastYear
        case meetSplitsSummaryResponse = "meetSplitStatisticResponse"
        case comparisonLastMeet = "summaryImprovementFromLastMeet"
    }
}
