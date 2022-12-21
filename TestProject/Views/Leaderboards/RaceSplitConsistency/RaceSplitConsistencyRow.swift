//
//  RaceSplitConsistencyRow.swift
//  UAXC
//
//  Created by David  Terkula on 12/14/22.
//

import SwiftUI

struct RaceSplitConsistencyRow: View {
    
    var rankedSplitConsistencyDTO: RankedSplitConsistencyDTO
    
    var body: some View {
        HStack {
            
            Text(String(rankedSplitConsistencyDTO.rank))
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(rankedSplitConsistencyDTO.runner.name)
                .foregroundColor(.primary)
                .font(.headline)
            
            Text(String(rankedSplitConsistencyDTO.consistencyValue))
                .foregroundColor(.primary)
                .font(.headline)
        }
    }
}

//struct RaceSplitConsistencyRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RaceSplitConsistencyRow()
//    }
//}
