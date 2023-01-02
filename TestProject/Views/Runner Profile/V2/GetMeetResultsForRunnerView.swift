//
//  GetMeetResultsForRunnerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/1/22.
//

import SwiftUI

struct GetMeetResultsForRunnerView: View {
    var results: [MeetResult]
    var body: some View {
        
        ForEach(results) { result in
            VStack {
                MeetResultViewV2(result: result)
                CustomDivider(color: GlobalFunctions.uaGreen(), height: 1.0)
            }
                
        }
    }
}



//struct GetMeetResultsForRunnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        GetMeetResultsForRunnerView()
//    }
//}
