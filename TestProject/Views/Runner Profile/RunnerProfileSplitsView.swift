//
//  RunnerProfileSplitsView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct RunnerProfileSplitsView: View {
    
    var splits: Splits
    
    var body: some View {
        HStack {
            Label("\(splits.mileOne)", systemImage: "1.circle")
                .foregroundColor(.white)
            Label("\(splits.mileTwo)", systemImage: "2.circle")
                .foregroundColor(.white)
            Label("\(splits.mileThree)", systemImage: "3.circle")
                .foregroundColor(.white)
            Label("avg: \(splits.average)", systemImage: "square.fill")
                .foregroundColor(.white)
        }.foregroundColor(.secondary)
            .font(.subheadline)
       
    }
}

//struct RunnerProfileSplitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerProfileSplitsView()
//    }
//}
