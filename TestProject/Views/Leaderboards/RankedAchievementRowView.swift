//
//  RankedAchievementRowView.swift
//  UAXC
//
//  Created by David  Terkula on 1/5/23.
//

import SwiftUI

struct RankedAchievementRowView: View {
   
    var rankedAchievementDTO: RankedAchievementDTO

    var body: some View {
        HStack {
            
            Text(String(rankedAchievementDTO.rank))
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(rankedAchievementDTO.runner.name)
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(String(rankedAchievementDTO.count))
                .foregroundColor(.primary)
                .font(.headline)
        }
    }
}


//struct RankedAchievementRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankedAchievementRowView()
//    }
//}
