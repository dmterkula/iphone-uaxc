//
//  SplitsListView.swift
//  UAXC
//
//  Created by David  Terkula on 11/1/22.
//

import SwiftUI

struct SplitsListView: View {
    
    @ObservedObject var splitsViewModel: SplitsListViewModel
    
    var body: some View {
        VStack {
            ForEach(splitsViewModel.splits) { split in
                SplitRow(number: split.number, time: split.time)
            }
        }
    }
}
//
//struct SplitsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplitsListView()
//    }
//}
