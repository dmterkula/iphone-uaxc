//
//  RunnerProfile.swift
//  UAXC
//
//  Created by David  Terkula on 8/30/22.
//

import Foundation

struct RunnerProfile: Codable {
    var adjustedTimeTrial: String?
    var runner: Runner
    var seasonBest: RunnerProfileSeasonBestDTO?
    var pr: RunnerProfilePR?
    var raceConsistencyRank: RaceConsistencyRankDTO?
    var timeTrialProgressionRank: ProgressionRankDTO?
    
    private enum CodingKeys: String, CodingKey {
            case adjustedTimeTrial = "adjustedTimeTrialTime"
            case timeTrialProgressionRank = "progressionRank"
            case runner, seasonBest, raceConsistencyRank, pr
        }
}
