//
//  MeetYearToYearProgressionList.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct MeetYearToYearProgressionList: View {

    var fasterProgressions: [Progression]
    var slowerProgressions: [Progression]
    
    var body: some View {
        Text("Faster than same meet last year: " + String(fasterProgressions.count))
        
        Text("Slower than same meet last year: " + String(slowerProgressions.count))
        
        List {
            ForEach(fasterProgressions + slowerProgressions) { progression in
                ProgressionView(progression: progression)
            }
        }
    }
    
}

//struct MeetYearToYearProgressionList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetYearToYearProgressionList()
//    }
//}
