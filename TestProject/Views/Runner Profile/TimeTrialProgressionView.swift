//
//  TimeTrialProgressionView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct TimeTrialProgressionView: View {
    
    var timeTrialProgressionRank: ProgressionRankDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Text("Time Trial ProgressionRank: ")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Text(String((timeTrialProgressionRank.rank)))
                    .foregroundColor(.white)
            }
            HStack(spacing: 10) {
                Text("+/- From Time Trial: ")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Text(String((timeTrialProgressionRank.improvementFromTimeTrial)))
                    .foregroundColor(.white)
            }
        }
    }
}

//struct TimeTrialProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialProgressionView()
//    }
//}
