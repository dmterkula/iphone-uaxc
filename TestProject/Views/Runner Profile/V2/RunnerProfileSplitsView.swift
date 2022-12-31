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
        VStack (alignment: .leading) {
            Label("\(splits.mileOne)", systemImage: "1.circle")
            Label("\(splits.mileTwo)", systemImage: "2.circle")
            Label("\(splits.mileThree)", systemImage: "3.circle")
            Label("avg: \(splits.average)", systemImage: "square.fill")
        }.foregroundColor(.secondary)
            .font(.subheadline)
       
    }
}

//struct RunnerProfileSplitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerProfileSplitsView()
//    }
//}
