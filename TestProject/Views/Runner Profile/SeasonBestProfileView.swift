//
//  SeasonBestProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct SeasonBestProfileView: View {
    var sb: RunnerProfileSeasonBestDTO
    var body: some View {
        VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    Text("SB:")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                    MeetResultView(result: sb.meetResult)
                
                }.padding(.vertical, 10.0)
                
            if( sb.meetSplits != nil) {
                HStack(spacing: 5) {
                    Text("Splits:")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()

                    RunnerProfileSplitsView(splits: sb.meetSplits!)
                }
            }
        }
    }
}


//struct SeasonBestProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeasonBestProfileView()
//    }
//}
