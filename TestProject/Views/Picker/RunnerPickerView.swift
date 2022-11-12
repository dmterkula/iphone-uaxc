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
        Menu {
            Picker("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""), selection: $runnerLabel, content: {
                ForEach(runners.map { $0.name + ": " + $0.graduatingClass }, id: \.self, content: { runnerLabel in
                    Text(runnerLabel).foregroundColor(.white)
                })
            })
            .pickerStyle(MenuPickerStyle())
            .accentColor(.white)
        } label : {
            Text("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""))
                .foregroundColor(.white)
                .font(.title2)
        }
        
        
    }
}

struct FilterRunnerPickerView: View {
    @Binding var runners: [Runner]
    @State var filterName: String = ""
    @Binding var runnerLabel: String
    @State var hidePreview = false
    
    var body: some View {
        
        TextField("", text: $filterName)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .placeholder(when: $filterName.wrappedValue.isEmpty) {
                HStack {
                    Spacer()
                    Text("Filter on name").foregroundColor(.white)
                        .hidden(hidePreview)
                    Spacer()
                }
            }.onTapGesture {
                hidePreview = true
            }
            .onChange(of: filterName) { [filterName] newValue in
                if (newValue.isEmpty) {
                    hidePreview = false
                }
           }
        
        VStack {
            Menu {
                if (filterName.isEmpty) {
                    Picker("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""), selection: $runnerLabel, content: {
                        ForEach(runners.map { $0.name + ": " + $0.graduatingClass }, id: \.self, content: { runnerLabel in
                            Text(runnerLabel).foregroundColor(.white)
                        })
                    })
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.white)
                } else {
                    Picker("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""), selection: $runnerLabel, content: {
                        ForEach(runners.filter{$0.name.contains(filterName)}.map { $0.name + ": " + $0.graduatingClass }, id: \.self, content: { runnerLabel in
                            Text(runnerLabel).foregroundColor(.white)
                        })
                    })
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.white)
                }
                
               
            } label : {
                Text("Selected Runner: " + (runnerLabel.components(separatedBy: ":").first ?? ""))
                    .foregroundColor(.white)
                    .font(.title2)
            }.onTapGesture {
                hideKeyboard()
            }
        }
        

        
        
    }
}

//struct RunnerPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunnerPickerView()
//    }
//}
