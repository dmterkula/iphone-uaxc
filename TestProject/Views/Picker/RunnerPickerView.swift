//
//  RunnerPickerView.swift
//  UAXC
//
//  Created by David  Terkula on 9/6/22.
//

import SwiftUI

struct RunnerPickerView: View {
    @Binding var runners: [Runner]
    @Binding var runnerLabel: String
    
    var body: some View {
        Picker("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""), selection: $runnerLabel, content: {
            ForEach(runners.map { $0.name + ": " + $0.graduatingClass }, id: \.self, content: { runnerLabel in
                Text(runnerLabel).foregroundColor(.white)
            })
        })
        .pickerStyle(MenuPickerStyle())
        .accentColor(.white)
        
    }
}

//struct RunnerPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerPickerView()
//    }
//}
