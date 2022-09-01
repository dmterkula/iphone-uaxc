//
//  MeetResultList.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct MeetResultList: View {
    var results: [MeetResult]
    
    var body: some View {
        List {
            ForEach(results) { result in
                MeetResultView(result: result)
            }
        }
    }
}



//struct MeetResultList_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetResultList()
//    }
//}
