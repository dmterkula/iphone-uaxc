//
//  MeetResultView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

struct MeetResultView: View {
    var result: MeetResult

    var body: some View {

        HStack(spacing: 20) {
            Text(result.time)
                .foregroundColor(.white)
                .font(.headline)
            VStack(alignment: .leading) {
                Label(result.meetName, systemImage: "person.3")
                    .foregroundColor(.white)
                Label(result.meetDate, systemImage: "calendar")
                    .foregroundColor(.white)
                Label("place: \(result.place)", systemImage: "person")
                    .foregroundColor(.white)
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }

    }
}

//struct MeetResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetResultView()
//    }
//}
