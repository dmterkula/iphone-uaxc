//
//  SBLeaderboardRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/13/22.
//

import SwiftUI

struct SBLeaderboardRow: View {
    var rankedSBDTO: RankedSBDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                
                Text(String(rankedSBDTO.rank))
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(rankedSBDTO.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            
            HStack(spacing: 3) {
                Label(rankedSBDTO.result.time, systemImage: "figure.run")
                Label("\(rankedSBDTO.result.meetName): \(rankedSBDTO.result.meetDate)", systemImage: "calendar.circle.fill")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}

//struct SBLeaderboardRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SBLeaderboardRow()
//    }
//}
