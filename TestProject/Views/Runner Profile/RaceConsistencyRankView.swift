//
//  RaceConsistencyRankView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct RaceConsistencyRankView: View {
    
    var raceConsistencyRank: RaceConsistencyRankDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Text("Race Split Consistency Rank: ")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Text(String((raceConsistencyRank.rank)))
                    .foregroundColor(.white)
            }
            HStack(spacing: 10) {
                Text("Avg Spread: ")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Text(String((raceConsistencyRank.averageSpread)))
                    .foregroundColor(.white)
            }
        }
    }
}

//struct RaceConsistencyRankView_Previews: PreviewProvider {
//    static var previews: some View {
//        RaceConsistencyRankView()
//    }
//}
