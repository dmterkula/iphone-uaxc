//
//  MeetSplitsList.swift
//  TestProject
//
//  Created by David  Terkula on 8/26/22.
//

import SwiftUI

struct MeetSplitsList: View {
    
    var meetSplits: [MeetSplit]
    
    var body: some View {
        List {
            ForEach(meetSplits) { split in
                MeetSplitView(meetSplit: split)
            }
        }.onTapGesture {
            hideKeyboard()
        }
    }
}
