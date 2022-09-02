//
//  AdjustedTimeTrialView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct AdjustedTimeTrialView: View {
    var adjustedTimeTrial: String
    var body: some View {
        HStack(spacing: 10) {
            Text("Adjusted Time Trial: ")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
            Text((adjustedTimeTrial))
                .foregroundColor(.white)
        }
    }
}

//struct AdjustedTimeTrialView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdjustedTimeTrialView()
//    }
//}
