//
//  MeetPickerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/6/22.
//

import SwiftUI

struct MeetPickerView: View {
    
    @Binding var meets: [MeetDTO]
    @Binding var meetName: String
    @Binding var season: String
    
    var pickerLabel: String = "Selected Meet: "
    
    var body: some View {

        Menu {
            Picker(pickerLabel + meetName, selection: $meetName, content: {
                
                if (season.isEmpty) {
                    ForEach(meets.map{$0.name}, id: \.self, content: { meetDTOName in
                        Text(meetDTOName).foregroundColor(.white)
                    })
                } else {
                    ForEach(meets.filter{ $0.dates.map{ $0.components(separatedBy: "-")[0] }.contains(season)}
                        .sorted(by: { $0.dates.first(where: { $0.contains(season) })! <
                            $1.dates.first(where: { $0.contains(season) })!
                        }).map{$0.name}, id: \.self, content: { meetDTOName in
                        Text(meetDTOName).foregroundColor(.white)
                    })
                }
            })
            .pickerStyle(MenuPickerStyle())
            .accentColor(.white)
            .labelsHidden()
        } label: {
            Text(pickerLabel + meetName)
                .foregroundColor(.white)
                .font(.title2)
        }

    }
}

//struct MeetPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetPickerView()
//    }
//}
