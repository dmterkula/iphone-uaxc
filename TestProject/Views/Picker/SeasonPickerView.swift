//
//  SeasonPickerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/6/22.
//

import SwiftUI

struct SeasonPickerView: View {
    
    @Binding var seasons: [String]
    @Binding var season: String
    
    var body: some View {
        Picker("Selected Season: " + season, selection: $season, content: {
            ForEach(seasons, id: \.self, content: { season in
                Text(season).foregroundColor(.white)
            })
        })
        .pickerStyle(MenuPickerStyle())
        .accentColor(.white)
        .labelsHidden()
        
    }
}

//struct SeasonPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeasonPickerView()
//    }
//}
