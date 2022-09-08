//
//  SeasonAndMeetPickerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/6/22.
//

import SwiftUI

struct SeasonAndMeetPickerView: View {
    @Binding var season: String
    @Binding var seasons: [String]
    @Binding var meets: [MeetDTO]
    @Binding var meetName: String
   
    var body: some View {
        VStack {
            HStack {
                SeasonPickerView(seasons: $seasons, season: $season)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
          
            
            
            if (!season.isEmpty) {
                HStack {
                    MeetPickerView(meets: $meets, meetName: $meetName, season: $season)
                }
                .padding(.top, 20)
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }
}

//struct SeasonAndMeetPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeasonAndMeetPickerView()
//    }
//}
