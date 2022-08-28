//
//  ProgressionView.swift
//  TestProject
//
//  Created by David  Terkula on 8/27/22.
//

import SwiftUI

struct ProgressionView: View {
    
    var progression: Progression
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(progression.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 3) {
                        Text("This Years Time:")
                            .bold()
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        Text(progression.meetResults[0].time)
                    }
                    HStack(spacing: 3) {
                        Text("Previous Years Time:")
                            .bold()
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        Text(progression.meetResults[1].time)
                    }
                    HStack(spacing: 3) {
                        Text("Difference:")
                            .bold()
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        Text(progression.progressions[0])
                    }
                }
                
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

//struct ProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressionView()
//    }
//}
