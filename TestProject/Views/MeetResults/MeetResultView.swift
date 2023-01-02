//
//  MeetResultView.swift
//  UAXC
//
//  Created by David  Terkula on 8/31/22.
//

import SwiftUI

//struct MeetResultView: View {
//    var result: MeetResult
//
//    var body: some View {
//
//        HStack(spacing: 20) {
//            Text(result.time)
//                .font(.headline)
//            VStack(alignment: .leading) {
//                Label(result.meetName, systemImage: "person.3")
//
//                Label(result.meetDate, systemImage: "calendar")
//
//                Label("place: \(result.place)", systemImage: "person")
//
//            }
//            .foregroundColor(.secondary)
//            .font(.subheadline)
//        }
//
//    }
//}

struct MeetResultViewV2: View {
    var result: MeetResult

    var body: some View {

        HStack(spacing: 20) {
            Text(result.time)
                .font(.headline)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Label(result.meetName, systemImage: "person.3")
       
                Label(result.meetDate, systemImage: "calendar")
                
                Label("place: \(result.place)", systemImage: "person")
                
                HStack {
                    Text("Passes 2nd Mile:")
                    Text(String (result.passesSecondMile))
                }
                
                HStack {
                    Text("Passes 3rd Mile:")
                    Text(String(result.passesLastMile))
                }
                
                HStack {
                    Text("Skull Beads: ")
                    Text(String(result.skullsEarned))
                }
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
            Spacer()
        }

    }
}

struct TotalMeetResultView: View {
    var result: TotalMeetPerformanceDTO
    
    var body: some View {
        HStack(spacing: 20) {
            Text(result.time)
                .font(.headline)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Label(result.meetName, systemImage: "person.3")
       
                Label(result.meetDate, systemImage: "calendar")
                
                Label("place: \(result.place)", systemImage: "person")
                
                HStack {
                    Text("Passes 2nd Mile:")
                    Text(String (result.passesSecondMile))
                }
                
                HStack {
                    Text("Passes 3rd Mile:")
                    Text(String(result.passesLastMile))
                }
                
                HStack {
                    Text("Skull Beads: ")
                    Text(String(result.skullsEarned))
                }
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
            Spacer()
        }
    }
}

//struct MeetResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetResultView()
//    }
//}
