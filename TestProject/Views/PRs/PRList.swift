//
//  PRList.swift
//  TestProject
//
//  Created by David  Terkula on 8/25/22.
//

import SwiftUI

struct PRList: View {
    
    var prs: [Performance]
    
    var body: some View {
        List {
            ForEach(prs) { pr in
                PRView(pr: pr)
            }
        }
    }
}
