//
//  TimeTrialDTOView.swift
//  UAXC
//
//  Created by David  Terkula on 9/2/22.
//

import SwiftUI

struct TimeTrialDTOView: View {
    var timeTrialDTO: TimeTrialResultsDTO
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 3) {
                Text(timeTrialDTO.runner.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                HStack(spacing: 3) {
                    Label(String(timeTrialDTO.place), systemImage: "figure.run")
                    Label(timeTrialDTO.time, systemImage: "stopwatch")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
    }
}

//struct TimeTrialDTOView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeTrialDTOView()
//    }
//}
