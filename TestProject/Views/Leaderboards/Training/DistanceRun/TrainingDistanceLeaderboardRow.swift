//
//  TrainingDistanceLeaderboardRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import SwiftUI

struct TrainingDistanceLeaderboardRow: View {
    var rankedRunnerDistanceRunDTO: RankedRunnerDistanceRunDTO
    
    var body: some View {
        HStack {
            
            Text(String(rankedRunnerDistanceRunDTO.rank))
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(rankedRunnerDistanceRunDTO.runner.name)
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(String(rankedRunnerDistanceRunDTO.distance))
                .foregroundColor(.primary)
                .font(.headline)
        }
    }
}

//struct TrainingDistanceLeaderboardRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingDistanceLeaderboardRow()
//    }
//}
