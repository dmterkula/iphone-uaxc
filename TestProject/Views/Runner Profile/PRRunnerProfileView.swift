//
//  PRRunnerProfileView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct PRRunnerProfileView: View {
    
    var pr: MeetResult
    
    var body: some View {
        VStack {
                HStack(spacing: 10) {
                    Text("PR: ")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                    MeetResultView(result: pr)
                
                }.padding(.vertical, 10.0)
        }
    }
}




//struct PRRunnerProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        PRRunnerProfileView()
//    }
//}
