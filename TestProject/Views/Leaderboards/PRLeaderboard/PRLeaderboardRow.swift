//
//  PRLeaderboardRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/11/22.
//

import SwiftUI

struct PRLeaderboardRow: View {
    
    var rankedPRDTO: RankedPRDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                
                Text(String(rankedPRDTO.rank))
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(rankedPRDTO.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
            }
            
            HStack(spacing: 3) {
                Label(rankedPRDTO.result.time, systemImage: "figure.run")
                Label("\(rankedPRDTO.result.meetName): \(rankedPRDTO.result.meetDate)", systemImage: "calendar.circle.fill")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}

//struct PRLeaderboardRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PRLeaderboardRow()
//    }
//}
