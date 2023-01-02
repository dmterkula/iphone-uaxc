//
//  SeasonBestProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct SeasonBestProfileView: View {
    var sb: RankedSBDTO
    var body: some View {
        HStack(spacing: 10) {
            Text("SB:")
                .font(.title3)
                .bold()
            
            MeetResultViewV2(result: sb.result)
        
        }
    }
}

struct SeasonBestSplitsView: View {
    var sb: RunnerProfileSeasonBestDTO
    var body: some View {
        if( sb.meetSplits != nil) {
            HStack(spacing: 10) {
                Text("Splits:")
                    .font(.title3)
                    .bold()

                RunnerProfileSplitsView(splits: sb.meetSplits!)
            }
        }
    }
}


//struct SeasonBestProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeasonBestProfileView()
//    }
//}
